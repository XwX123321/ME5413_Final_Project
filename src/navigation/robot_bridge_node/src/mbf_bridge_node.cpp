#include <robot_bridge_node/mbf_bridge_node.h>

MbfBridge::MbfBridge(/* args */)
{
    ros::NodeHandle simple_nh;
    goal_sub_ = simple_nh.subscribe<geometry_msgs::PoseStamped>("move_base_simple/goal", 1, boost::bind(&MbfBridge::goalCB, this, _1));
    ros::NodeHandle action_nh;
    action_pub_ = action_nh.advertise<mbf_msgs::MoveBaseActionGoal>("move_base_flex/move_base/goal", 1);
}

MbfBridge::~MbfBridge()
{
}

void MbfBridge::goalCB(const geometry_msgs::PoseStamped::ConstPtr &goal)
{
    mbf_msgs::MoveBaseActionGoal action_goal;
    action_goal.header.frame_id = 'map';
    action_goal.header.stamp = ros::Time::now();
    action_goal.goal.target_pose = *goal;
    action_pub_.publish(action_goal);
}

int main(int argc, char **argv)
{
    ros::init(argc, argv, "xju_mbf_bridge");
    MbfBridge _bridge;
    ros::spin();
    return 0;
}
