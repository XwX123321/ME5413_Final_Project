#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import rospy
import math
from geometry_msgs.msg import PoseStamped
import tf
import tf2_ros
from tf2_geometry_msgs import do_transform_pose
from tf2_ros import TransformBroadcaster, TransformStamped
from yolov8_ros_msgs.msg import BoundingBoxes
from move_demo.srv import CamToReal, CamToRealResponse, CamToRealRequest
from move_demo.srv import FindNearestModel, FindNearestModelResponse, FindNearestModelRequest
from gazebo_msgs.srv import DeleteModel

class TfBroadcast:
    def __init__(self):
        rospy.init_node('tf_broadcast')
        self.tf_broadcaster = TransformBroadcaster()
       
        # 用于累积统计各类别出现次数的字典
        self.class_counts = {}

        # 初始化 tf2 缓冲区和监听器
        self.tf_buffer = tf2_ros.Buffer()
        self.tf_listener = tf2_ros.TransformListener(self.tf_buffer)
       
        # 等待并创建 cam_to_real 服务代理
        rospy.wait_for_service('cam_to_real')
        self.dist_client = rospy.ServiceProxy('cam_to_real', CamToReal)
        self.dist_req = CamToRealRequest()

        # 等待并创建 find_nearest_model 服务代理
        rospy.wait_for_service('find_nearest_model')
        self.find_nearest_client = rospy.ServiceProxy('find_nearest_model', FindNearestModel)
       
        rospy.Subscriber('/yolov8/BoundingBoxes', BoundingBoxes, self.yolo_callback)

    def save_class_counts(self):
        """
        将当前累积的统计数据保存到文本文件中
        """
        try:
            with open("/home/xwx/hw_ws/src/class_counts.txt", "w") as f:
                f.write(str(self.class_counts))
        except Exception as e:
            rospy.logerr("Failed to save class counts: %s", str(e))

    def yolo_callback(self, yolo_tmp):
        # 如果没有检测到任何 bounding box，则直接返回
        if not yolo_tmp.bounding_boxes:
            return

        # 计算目标在图像中的中心点坐标
        pixel_x = (yolo_tmp.bounding_boxes[0].xmin + yolo_tmp.bounding_boxes[0].xmax) / 2.0
        pixel_y = (yolo_tmp.bounding_boxes[0].ymin + yolo_tmp.bounding_boxes[0].ymax) / 2.0

        # 调用 cam_to_real 服务，将像素坐标转换为相机坐标系下的真实世界坐标
        self.dist_req.pixel_x = pixel_x
        self.dist_req.pixel_y = pixel_y
        try:
            dist_resp = self.dist_client.call(self.dist_req)
        except rospy.ServiceException as e:
            rospy.logerr("cam_to_real service call failed: %s", str(e))
            return

        if dist_resp.obj_x == 0:
            return

        # 构造在相机坐标系下的物体位姿（坐标系为 front_camera_optical）
        object_pose_cam = PoseStamped()
        object_pose_cam.header.stamp = rospy.Time.now()
        object_pose_cam.header.frame_id = "front_camera_optical"
        object_pose_cam.pose.position.x = dist_resp.obj_x
        object_pose_cam.pose.position.y = dist_resp.obj_y
        object_pose_cam.pose.position.z = dist_resp.obj_z
        object_pose_cam.pose.orientation.x = 0.0
        object_pose_cam.pose.orientation.y = 0.0
        object_pose_cam.pose.orientation.z = 0.0
        object_pose_cam.pose.orientation.w = 1.0

        # 将物体位姿从相机坐标系转换到地图坐标系（map）
        try:
            map_pose = self.tf_buffer.transform(object_pose_cam, "map", rospy.Duration(1.0))
        except (tf2_ros.LookupException, tf2_ros.ConnectivityException,
                tf2_ros.ExtrapolationException) as e:
            rospy.logerr("Transform error: %s", str(e))
            return

        rospy.loginfo("Map coordinates: x=%f, y=%f, z=%f",
                      map_pose.pose.position.x, map_pose.pose.position.y, map_pose.pose.position.z)

        # 广播物体在地图坐标系下的 TF 变换（可选）
        transform = TransformStamped()
        transform.header.stamp = rospy.Time.now()
        transform.header.frame_id = "map"
        transform.child_frame_id = "object"
        transform.transform.translation.x = map_pose.pose.position.x
        transform.transform.translation.y = map_pose.pose.position.y
        transform.transform.translation.z = map_pose.pose.position.z
        transform.transform.rotation.x = map_pose.pose.orientation.x
        transform.transform.rotation.y = map_pose.pose.orientation.y
        transform.transform.rotation.z = map_pose.pose.orientation.z
        transform.transform.rotation.w = map_pose.pose.orientation.w

        self.tf_broadcaster.sendTransform(transform)

        # 查询机器人在地图坐标系下的位姿，假设机器人的 tf 坐标为 "base_link"
        try:
            robot_transform = self.tf_buffer.lookup_transform("map", "base_link", rospy.Time(0), rospy.Duration(1.0))
        except (tf2_ros.LookupException, tf2_ros.ConnectivityException, tf2_ros.ExtrapolationException) as e:
            rospy.logerr("Failed to get robot transform: %s", str(e))
            return

        robot_x = robot_transform.transform.translation.x
        robot_y = robot_transform.transform.translation.y
        robot_z = robot_transform.transform.translation.z

        # 计算机器人与目标之间的距离
        distance = math.sqrt((map_pose.pose.position.x - robot_x)**2 +
                             (map_pose.pose.position.y - robot_y)**2 +
                             (map_pose.pose.position.z - robot_z)**2)
        if distance >= 5.0:
            return

        # 使用转换后的地图坐标调用 find_nearest_model 服务寻找最近的物体
        find_req = FindNearestModelRequest()
        find_req.x = map_pose.pose.position.x
        find_req.y = map_pose.pose.position.y
        find_req.z = map_pose.pose.position.z
        try:
            find_resp = self.find_nearest_client.call(find_req)
        except rospy.ServiceException as e:
            return

        model_to_delete = find_resp.model_name

        # 删除找到的模型，避免重复统计
        rospy.wait_for_service('/gazebo/delete_model')
        try:
            delete_model_client = rospy.ServiceProxy('/gazebo/delete_model', DeleteModel)
            delete_resp = delete_model_client(model_to_delete)
        except rospy.ServiceException as e:
            return

        if '_' in model_to_delete:
            class_name = model_to_delete.split('_')[0]
        else:
            class_name = model_to_delete

        # 累计统计该类别的数量
        self.class_counts[class_name] = self.class_counts.get(class_name, 0) + 1
        rospy.loginfo("Cumulative class counts: %s", self.class_counts)
        # 将统计数据保存到文本文件中
        self.save_class_counts()

    def run(self):
        rospy.spin()

if __name__ == '__main__':
    try:
        tf_broadcast = TfBroadcast()
        tf_broadcast.run()
    except rospy.ROSInterruptException:
        pass
