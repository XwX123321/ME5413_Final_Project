#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import rospy
import tf
import actionlib
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal
from actionlib_msgs.msg import GoalStatus
from gazebo_msgs.srv import SetModelState, SetModelStateRequest, GetModelState
from gazebo_msgs.msg import ModelState
from std_srvs.srv import Trigger
from geometry_msgs.msg import Twist
import math
from std_msgs.msg import Bool
import ast

class PatrolBot:
    def __init__(self):
        rospy.init_node('patrol_bot', anonymous=True)
        # 创建 move_base 的 action client，并等待服务端启动
        self.move_base_client = actionlib.SimpleActionClient('move_base', MoveBaseAction)
        rospy.loginfo("Waiting for move_base action server...")
        self.move_base_client.wait_for_server()
        rospy.loginfo("Connected to move_base action server.")

        self.set_model_srv = rospy.ServiceProxy('/gazebo/set_model_state', SetModelState)
        self.set_model_srv.wait_for_service()

        self.get_model_state_srv = rospy.ServiceProxy('/gazebo/get_model_state', GetModelState)
        self.get_model_state_srv.wait_for_service()

        self.vel_pub = rospy.Publisher('cmd_vel', Twist, queue_size=10)
        self.bridge_pub = rospy.Publisher('/cmd_open_bridge', Bool, queue_size=10)
        
        # 标志位，用于判断是否完成导航
        self.move_finish = False

    def get_jackal_position(self):
        """
        调用 Gazebo 的 /gazebo/get_model_state 服务获取 jackal 模型在 world 坐标系下的位置
        :return: (x, y, z) 坐标元组，如果失败则返回 None
        """
        try:
            resp = self.get_model_state_srv("jackal", "world")
            return (resp.pose.position.x, resp.pose.position.y, resp.pose.position.z)
        except rospy.ServiceException as e:
            rospy.logerr("Failed to get jackal position: %s", e)
            return None

    def set_model(self, model_name, position_x, position_y, position_z, ang):
        try:
            # rospy.loginfo(f"Setting model {model_name} to position ({position_x}, {position_y}, {position_z})")
            set_model_req = SetModelStateRequest()
           
            # Create the ModelState object
            model_state = ModelState()
            model_state.model_name = model_name
            model_state.pose.position.x = position_x
            model_state.pose.position.y = position_y
            model_state.pose.position.z = position_z

            if ang == 0:
                model_state.pose.orientation.x = 0.0
                model_state.pose.orientation.y = 0.0
                model_state.pose.orientation.z = 1.0
                model_state.pose.orientation.w = 0.0

            elif ang == 1:
                model_state.pose.orientation.x = 0.0
                model_state.pose.orientation.y = 0.0
                model_state.pose.orientation.z = -0.707
                model_state.pose.orientation.w = 0.707

            # Set model state in the request
            set_model_req.model_state = model_state
           
            # Call the service
            self.set_model_srv(set_model_req)
            # rospy.loginfo(f"Model {model_name} position set successfully.")
        except rospy.ServiceException as e:
            print(1)

    def call_find_bridge_service(self):
        rospy.wait_for_service('find_bridge')
        try:
            find_bridge = rospy.ServiceProxy('find_bridge', Trigger)
            rospy.loginfo("Calling find_bridge service...")
            response = find_bridge()  # 调用服务
            rospy.loginfo("Service call succeeded. Robot has stopped.")
        except rospy.ServiceException as e:
            rospy.logerr("Service call failed: %s", e)


    def open_bridge(self):
        """
        发布 /cmd_open_bridge 话题的 Bool 消息，将 data 设置为 True
        """
        msg = Bool()
        msg.data = True
        rospy.loginfo("Publishing open_bridge command: True")
        self.bridge_pub.publish(msg)
        # 可选择等待一小段时间，确保消息发布出去
        rospy.sleep(0.5)

    def send_goal(self, x, y, theta):
        """
        发送目标点到 move_base 进行导航
        :param x: 目标点在 map 坐标系下的 x 坐标
        :param y: 目标点在 map 坐标系下的 y 坐标
        :param theta: 目标点期望朝向的偏航角（弧度制）
        :return: True 如果目标到达成功，否则 False
        """
        goal = MoveBaseGoal()
        goal.target_pose.header.frame_id = "map"
        goal.target_pose.header.stamp = rospy.Time.now()
       
        # 设置目标点位置
        goal.target_pose.pose.position.x = x
        goal.target_pose.pose.position.y = y
        goal.target_pose.pose.position.z = 0.0
       
        # 将偏航角转换为四元数表示
        quat = tf.transformations.quaternion_from_euler(0, 0, theta)
        goal.target_pose.pose.orientation.x = quat[0]
        goal.target_pose.pose.orientation.y = quat[1]
        goal.target_pose.pose.orientation.z = quat[2]
        goal.target_pose.pose.orientation.w = quat[3]
       
        rospy.loginfo("Sending goal: x=%.2f, y=%.2f, theta=%.2f", x, y, theta)
        self.move_base_client.send_goal(goal)
        self.move_base_client.wait_for_result()
       
        state = self.move_base_client.get_state()
        if state == GoalStatus.SUCCEEDED:
            rospy.loginfo("Goal reached successfully!")
            return True
        else:
            rospy.loginfo("Failed to reach goal. State: %d", state)
            return False

    def rotate_90(self, angular_speed=0.5):
        """
        让小车旋转90度（π/2 弧度）。
        该方法会不断循环发布 Twist 消息，直到累计旋转角度达到90度，然后停止。
        :param angular_speed: 旋转的角速度（rad/s），默认0.5 rad/s
        """
        target_angle = math.pi / 2.0  # 90度对应弧度
        duration = target_angle / angular_speed  # 所需时间
        rospy.loginfo("Rotating 90° with angular speed: %.2f rad/s, duration: %.2f seconds", angular_speed, duration)
        rate = rospy.Rate(10)  # 10Hz循环
        start_time = rospy.Time.now()
        twist = Twist()
        twist.linear.x = 0.0
        twist.angular.z = angular_speed
        while not rospy.is_shutdown():
            elapsed = (rospy.Time.now() - start_time).to_sec()
            if elapsed >= duration:
                break
            self.vel_pub.publish(twist)
            rate.sleep()
        # 停止旋转
        twist.angular.z = 0.0
        self.vel_pub.publish(twist)
        rospy.loginfo("Rotation complete.")

    def drive_distance(self, distance, linear_speed=0.5):
        """
        让小车沿前方直线行驶指定距离（单位：米）。
        根据给定速度计算所需时间，不断发布 Twist 消息，行驶完成后停止。
        :param distance: 行驶的距离（正值表示向前，负值表示向后）
        :param linear_speed: 行驶速度（m/s），默认 0.5 m/s
        """
        duration = abs(distance) / linear_speed
        rospy.loginfo("Driving distance: %.2f m at speed: %.2f m/s, duration: %.2f seconds", distance, linear_speed, duration)
        rate = rospy.Rate(10)  # 10Hz循环
        twist = Twist()
        twist.linear.x = linear_speed if distance >= 0 else -linear_speed
        twist.angular.z = 0.0
        start_time = rospy.Time.now()
        while not rospy.is_shutdown():
            elapsed = (rospy.Time.now() - start_time).to_sec()
            if elapsed >= duration:
                break
            self.vel_pub.publish(twist)
            rate.sleep()
        twist.linear.x = 0.0
        self.vel_pub.publish(twist)
        rospy.loginfo("Drive distance complete.")

    def get_least_frequent_class(self):
        """
        读取保存类别统计的 txt 文件，找出出现次数最少的类别，
        然后提取其中的数字，并将数字转换为英文单词返回。
        例如，若文件内容为
            {'number5': 1, 'number9': 1, 'number8': 1, 'number1': 3}
        则返回 "five"（出现次数最少的为5）。
        """
        file_path = "/home/xwx/hw_ws/src/class_counts.txt/class_counts.txt"
        try:
            with open(file_path, "r") as f:
                content = f.read().strip()
            if not content:
                rospy.logwarn("No data in class counts file.")
                return None
            counts = ast.literal_eval(content)
            if not counts:
                rospy.logwarn("Empty dictionary in class counts file.")
                return None
            least_freq_key = min(counts, key=counts.get)
            if least_freq_key.startswith("number"):
                digit = least_freq_key[len("number"):]
            else:
                digit = least_freq_key
            mapping = {
                "0": "zero", "1": "one", "2": "two", "3": "three", "4": "four",
                "5": "five", "6": "six", "7": "seven", "8": "eight", "9": "nine"
            }
            english_word = mapping.get(digit, digit)
            rospy.loginfo("Least frequent class: %s, which maps to: %s", least_freq_key, english_word)
            return english_word
        except Exception as e:
            rospy.logerr("Failed to get least frequent class: %s", e)
            return None

    def get_bounding_box_class(self):
        """
        调用之前写好的服务 get_bounding_box_class，返回检测到的类别名称。
        假设服务类型为 std_srvs/Trigger，返回消息字段中包含类别名称。
        """
        try:
            rospy.wait_for_service('get_bounding_box_class', timeout=5.0)
            get_bb = rospy.ServiceProxy('get_bounding_box_class', Trigger)
            resp = get_bb()
            if resp.success:
                rospy.loginfo("get_bounding_box_class returned: %s", resp.message)
                return resp.message
            else:
                rospy.logwarn("get_bounding_box_class service call unsuccessful: %s", resp.message)
                return None
        except rospy.ServiceException as e:
            rospy.logerr("Service call failed: %s", e)
            return None
        except rospy.ROSException as e:
            rospy.logwarn("Timeout waiting for get_bounding_box_class service: %s", e)
            return None
        
    def patrol(self):
        
        rospy.loginfo("Starting patrol")

        # 1. 避障
        success = self.send_goal(22.17, 19.73, -2.44)

        # 2. 计数

        self.send_goal(2.27, 19.61, 0.0)
        self.send_goal(22.55, 17.46, -3.14)
        self.send_goal(2.12, 15.90, 0.0)
        self.send_goal(22.55, 15.46, -3.14)
        self.send_goal(2.12, 12.90, 0.0)
        self.send_goal(22.55, 12.46, -3.14)

        # 3和4. 过桥

        self.send_goal(22.475, 10.263, 3.14)
        self.set_model('jackal', 22.475, 10.263, 2.67, 0)
        rospy.sleep(1)
        self.call_find_bridge_service()
        self.rotate_90(angular_speed=0.5)

        pos = self.get_jackal_position()
        if pos is not None:
            self.set_model('jackal', pos[0], pos[1], pos[2], 1)
        
        rospy.sleep(0.5)
        
        self.drive_distance(2.0)
        self.open_bridge()
        self.drive_distance(4.0)

        # 5. 去往最多的类

        least_freq = self.get_least_frequent_class()
        if least_freq is not None:
            rospy.loginfo("Least frequent class: %s", least_freq)

        self.send_goal(5.92, 2.10, -1.5708)
        model_name = self.get_bounding_box_class()
        if model_name == least_freq:
            self.move_finish = True
            return

        self.send_goal(9.90, 2.10, -1.5708)
        model_name = self.get_bounding_box_class()
        if model_name == least_freq:
            self.move_finish = True
            return
        
        self.send_goal(14.07, 2.10, -1.5708)
        model_name = self.get_bounding_box_class()
        if model_name == least_freq:
            self.move_finish = True
            return
        
        self.send_goal(18.21, 2.10, -1.5708)

        self.move_finish = True

if __name__ == "__main__":
    try:
        patrol_bot = PatrolBot()
        while not rospy.is_shutdown() and not patrol_bot.move_finish:
            patrol_bot.patrol()
    except rospy.ROSInterruptException:
        rospy.loginfo("PatrolBot node terminated.")
