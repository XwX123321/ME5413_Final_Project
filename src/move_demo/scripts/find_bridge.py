#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import rospy
import math
from sensor_msgs.msg import LaserScan
from geometry_msgs.msg import Twist
from std_srvs.srv import Trigger, TriggerResponse

class RobotControllerService:
    def __init__(self):
        rospy.init_node('robot_controller_service', anonymous=True)
        # 发布控制机器人运动的 cmd_vel 消息
        self.cmd_vel_pub = rospy.Publisher('/cmd_vel', Twist, queue_size=10)
        self.service = rospy.Service('find_bridge', Trigger, self.control_callback)
        rospy.loginfo("Robot Controller Service node started.")

    def control_callback(self, req):
        """
        服务回调函数：
        循环读取 /front/scan 的激光数据，
        当机器人左侧（90°方向）的距离在 2～3 m 范围内时，发布零速停止机器人，并返回响应。
        否则以 0.5 m/s 向前运动。
        """
        rate = rospy.Rate(10)  # 控制循环频率 10Hz
        rospy.loginfo("Service called: controlling robot until left distance is between 2 and 3 m.")
        while not rospy.is_shutdown():
            try:
                # 等待激光数据（超时 1 秒）
                scan_msg = rospy.wait_for_message('/front/scan', LaserScan, timeout=1.0)
            except rospy.ROSException as e:
                rospy.logwarn("Timeout waiting for scan message: %s", str(e))
                continue

            desired_angle = math.pi / 2
            # 计算对应的数组索引：index = (desired_angle - angle_min) / angle_increment
            index = int(round((desired_angle - scan_msg.angle_min) / scan_msg.angle_increment))
            if index < 0 or index >= len(scan_msg.ranges):
                rospy.logwarn("Computed index %d is out of bounds.", index)
                continue

            left_distance = scan_msg.ranges[index]
            rospy.loginfo("Left distance: %.2f m", left_distance)

            twist = Twist()
            if 2.5 <= left_distance <= 3.5:
                rospy.sleep(0.5)
                # 达到目标距离，停止机器人
                twist.linear.x = 0.0
                self.cmd_vel_pub.publish(twist)
                rospy.loginfo("Left distance within [2.5,3.5] m, stopping robot.")
                return TriggerResponse(success=True, message="Robot stopped with left distance: %.2f m" % left_distance)
            else:
                # 未达到目标，继续前进
                twist.linear.x = 0.5
                self.cmd_vel_pub.publish(twist)
            rate.sleep()

    def run(self):
        rospy.spin()

if __name__ == '__main__':
    try:
        service_node = RobotControllerService()
        service_node.run()
    except rospy.ROSInterruptException:
        rospy.loginfo("Robot Controller Service node terminated.")
