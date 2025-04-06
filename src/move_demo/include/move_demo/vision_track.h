#ifndef VISION_TRACK_H
#define VISION_TRACK_H

#include <iostream>
#include <ros/ros.h>
#include <image_transport/image_transport.h>
#include <sensor_msgs/Image.h>
#include <cv_bridge/cv_bridge.h>
#include <std_msgs/String.h>
#include <cstring>
#include <geometry_msgs/Twist.h>
#include <yolov8_ros_msgs/BoundingBoxes.h>
#include "move_demo/TrackObj.h"

class Tracker
{

private:
    ros::NodeHandle nh_;
    image_transport::ImageTransport it_;
    image_transport::Subscriber image_sub_;
    image_transport::Subscriber depth_sub_;
    ros::Subscriber vision_sub_;
    cv::Mat depthimage = cv::Mat::zeros(480, 640, CV_32FC1); // camera_info
    cv::Rect result;
    bool begin_track, first_time;
    double distance, distance_previous;
    int center_x, center_y;
    geometry_msgs::Twist twist;
    ros::ServiceServer obj_track;
    bool track_finish;
    std::string Object;

public:
    Tracker();
    ~Tracker();
    ros::Publisher vel_pub_;
    float rotation_speed, linear_speed;
    void imageCb(const sensor_msgs::ImageConstPtr &msg);
    void depthCb(const sensor_msgs::ImageConstPtr &msg);
    void visionCb(const yolov8_ros_msgs::BoundingBoxes &msg);
    void track_obj();
    bool objTrackCb(move_demo::TrackObj::Request &req,
                    move_demo::TrackObj::Response &res);
};

#endif