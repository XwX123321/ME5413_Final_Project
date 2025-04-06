#include "move_demo/vision_track.h"

Tracker::Tracker() : it_(nh_), begin_track(false), first_time(true), distance_previous(5), track_finish(false)
{
    image_sub_ = it_.subscribe("/camera/rgb/image_raw", 1, &Tracker::imageCb, this);
    depth_sub_ = it_.subscribe("/camera/depth/image_raw", 1, &Tracker::depthCb, this);
    vision_sub_ = nh_.subscribe("/yolov8/BoundingBoxes", 1, &Tracker::visionCb, this);
    vel_pub_ = nh_.advertise<geometry_msgs::Twist>("/cmd_vel", 1000);
    obj_track = nh_.advertiseService("track_obj", &Tracker::objTrackCb, this);
}

Tracker::~Tracker()
{
}

void Tracker::imageCb(const sensor_msgs::ImageConstPtr &msg)
{
    cv_bridge::CvImagePtr cv_ptr;
    try
    {
        // ros 图像转化到opencv
        cv_ptr = cv_bridge::toCvCopy(msg, sensor_msgs::image_encodings::BGR8);
    }
    catch (cv_bridge::Exception &e)
    {
        ROS_ERROR("cv_bridge exception: %s", e.what());
        return;
    }
}

void Tracker::depthCb(const sensor_msgs::ImageConstPtr &msg)
{
    cv_bridge::CvImagePtr cv_ptr;
    try
    {
        // ros 图像转化到opencv
        cv_ptr = cv_bridge::toCvCopy(msg, sensor_msgs::image_encodings::TYPE_32FC1);
        cv_ptr->image.copyTo(depthimage);
    }
    catch (cv_bridge::Exception &e)
    {
        ROS_ERROR("Could not convert from '%s' to 'TYPE_32FC1'.", msg->encoding.c_str());
    }

    if (begin_track == true)
    {
        double distance_min = 10;
        for (int j = result.y ; j < result.y + 10 ; j = j + 1)
        {
            distance = depthimage.at<float>(j, result.x) ;
            if (distance < distance_min && distance != 0)
            {
                distance_min = distance;
            }
        }

        if (distance == 20)

        {
            distance = 0.5;
        }
        
        std::cout << "distance " << distance << std::endl;

        center_x =  result.x;

        std::cout << "center_x" << center_x << std::endl;

        center_y = result.y;

        //std::cout << "center_y" << center_y << std::endl;
    }
}

void Tracker::visionCb(const  yolov8_ros_msgs::BoundingBoxes &bbox_tmp)
{
    for (int i = 0; i < bbox_tmp.bounding_boxes.size(); i++)
    {

            result.x = (bbox_tmp.bounding_boxes[i].xmin + bbox_tmp.bounding_boxes[i].xmax) / 2.0; 
            result.y = (bbox_tmp.bounding_boxes[i].ymin + bbox_tmp.bounding_boxes[i].ymax) / 2.0;
            begin_track = true;
            first_time = false;

    }
}

void Tracker::track_obj()
{
    ros::AsyncSpinner spinner(1);
    spinner.start();
    if (begin_track == true)
    {

        rotation_speed = -20*(center_x - 320)/10000.0;  //pid
        std::cout << rotation_speed << std::endl;

        if (rotation_speed > 1.0)
        {
            rotation_speed = 1.0;
        }

        if (rotation_speed < -1.0)
        {
            rotation_speed = -1.0;
        }

        if (distance < 0.15)
        {
            linear_speed = 0.0;
        }
        else
        {
            linear_speed = (distance - 0.15) * 0.5;
        }

        if (linear_speed > 0.5)
        {
            linear_speed = 0.5;
        }

        if (linear_speed < 0.0)
        {
            linear_speed = 0.0;
        }

        twist.linear.x = linear_speed;
        twist.linear.y = 0;
        twist.linear.z = 0;
        twist.angular.x = 0;
        twist.angular.y = 0;
        twist.angular.z = rotation_speed;
        vel_pub_.publish(twist);

        if (distance < 0.16 && center_x >300 && center_x < 340)
        {
            twist.linear.x = 0;
            twist.linear.y = 0;
            twist.linear.z = 0;
            twist.angular.x = 0;
            twist.angular.y = 0;
            twist.angular.z = 0;
            vel_pub_.publish(twist);
            track_finish = true;
        }
    }
}

bool Tracker::objTrackCb(move_demo::TrackObj::Request &req,
                         move_demo::TrackObj::Response &res)
{
    try
    {
        Object = req.obj;
        while(!track_finish)
        {
            track_obj();
        }
        track_finish = false;
        res.result = true;

    }
    catch(const std::exception& e)
    {
        ROS_WARN_STREAM("grasp obj error : " << e.what());
    }
    
}
int main(int argc, char **argv)
{
    ros::init(argc, argv, "vision_tracker");
    while (ros::ok())
    {
        Tracker tracker;
        ros::AsyncSpinner spinner(1);
        spinner.start();
        ros::waitForShutdown();
    }
    

    return 0;
}