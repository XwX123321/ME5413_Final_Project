#ifndef MBF_BRIDGE_NODE_H
#define MBF_BRIDGE_NODE_H

#include <iostream>
#include <ros/ros.h>
#include <geometry_msgs/PoseStamped.h>
#include <mbf_msgs/MoveBaseActionGoal.h>

class MbfBridge
{
private:
    ros::Subscriber goal_sub_;
    ros::Publisher action_pub_;

public:
    MbfBridge(/* args */);
    ~MbfBridge();
    void goalCB(const geometry_msgs::PoseStamped::ConstPtr &goal);
};

#endif
