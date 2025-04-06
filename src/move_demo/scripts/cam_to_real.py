#!/usr/bin/env python3
import rospy
from cv_bridge import CvBridge
from sensor_msgs.msg import Image, CameraInfo
from move_demo.srv import CamToReal, CamToRealResponse
import cv2
import math
import numpy as np


class ImageConverter:
    def __init__(self):
        self.bridge = CvBridge()
        self.color_image = None
        self.depth_image = np.zeros((480, 640), dtype=np.float32)  # camera_info
        self.camera_info = None

        self.image_sub_depth = rospy.Subscriber(
            "/camera/depth/image_raw", Image, self.image_depth_callback)
        self.image_sub_color = rospy.Subscriber(
            "/camera/rgb/image_raw", Image, self.image_color_callback)
        self.camera_info_sub_ = rospy.Subscriber(
            "/camera/depth/camera_info", CameraInfo, self.camera_info_callback)
        self.cam_to_real = rospy.Service(
            "/cam_to_real", CamToReal, self.cam_to_real_callback)

    def camera_info_callback(self, msg):
        self.camera_info = msg

    def image_depth_callback(self, msg):
        self.depth_image = self.bridge.imgmsg_to_cv2(
            msg, desired_encoding="passthrough")

    def image_color_callback(self, msg):
        self.color_image = self.bridge.imgmsg_to_cv2(
            msg, desired_encoding="bgr8")

    def cam_to_real_callback(self, req):

        if self.depth_image is None or self.camera_info is None:
            return
        
        mid_pos = [int(req.pixel_x), int(req.pixel_y)]
        window_size = 20  # This should be set as per your requirement
        get_distance = False

        for i in range(window_size):

            if get_distance:
                break
            for j in range(mid_pos[0] - i, mid_pos[0] + i + 1):
                for k in range(mid_pos[1] - i, mid_pos[1] + i + 1):

                    if 0 <= k < self.depth_image.shape[0] and 0 <= j < self.depth_image.shape[1]:
                        dist = self.depth_image[k, j]
                        if dist != 0 and not np.isnan(dist):
                            depth = dist 
                            mid_pos = [j, k]
                            get_distance = True
                            break

                if get_distance:
                    break

        if get_distance:
            real_x = (mid_pos[0] - self.camera_info.K[2]) / self.camera_info.K[0] * depth
            real_y = (mid_pos[1] - self.camera_info.K[5]) / self.camera_info.K[4] * depth
            return CamToRealResponse(real_x, real_y, depth, True)
        
        else:
            return CamToRealResponse(0, 0, 0, False)


def main():
    rospy.init_node('detect_obj')
    ic = ImageConverter()
    rospy.spin()


if __name__ == '__main__':
    main()
