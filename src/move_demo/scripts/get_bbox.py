#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import rospy
from yolov8_ros_msgs.msg import BoundingBoxes
from std_srvs.srv import Trigger, TriggerResponse

class BoundingBoxService:
    def __init__(self):
        rospy.init_node('bounding_box_service', anonymous=True)
        # 用于保存最新接收到的类别名称
        self.last_class = None
        # 订阅 /yolov8/BoundingBoxes 话题，更新最新类别
        rospy.Subscriber('/yolov8/BoundingBoxes', BoundingBoxes, self.bb_callback)
        # 创建服务，当请求时返回类别名称
        self.srv = rospy.Service('get_bounding_box_class', Trigger, self.handle_get_class)
        rospy.loginfo("Service 'get_bounding_box_class' is ready.")
        rospy.spin()

    def bb_callback(self, msg):
        # 如果检测到目标，则保存第一个 bounding box 的类别字段
        if msg.bounding_boxes:
            self.last_class = msg.bounding_boxes[0].Class
            rospy.loginfo("Updated last bounding box class: %s", self.last_class)

    def handle_get_class(self, req):
        # 如果有类别数据，则返回，否则返回错误信息
        if self.last_class:
            return TriggerResponse(success=True, message=self.last_class)
        else:
            return TriggerResponse(success=False, message="No bounding box detected yet.")

if __name__ == '__main__':
    try:
        BoundingBoxService()
    except rospy.ROSInterruptException:
        pass


