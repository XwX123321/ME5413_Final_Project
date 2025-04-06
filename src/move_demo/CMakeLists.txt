cmake_minimum_required(VERSION 3.0.2)
project(move_demo)

add_compile_options(-std=c++11)

find_package(catkin REQUIRED COMPONENTS
  cv_bridge
  image_transport
  roscpp
  rospy
  std_msgs
  moveit_msgs
  moveit_ros_perception
  moveit_ros_planning_interface
  trajectory_msgs
  message_generation
  message_runtime
)

find_package(OpenCV REQUIRED)


add_service_files(
  FILES
  TrackObj.srv
  FindNearestModel.srv
  CamToReal.srv
)


generate_messages(
  DEPENDENCIES
  std_msgs
)


catkin_package(
  CATKIN_DEPENDS roscpp rospy std_msgs moveit_core moveit_ros_planning_interface
)

include_directories(
  include
  ${catkin_INCLUDE_DIRS}
)

add_executable(track_srv src/track_srv.cpp)
target_link_libraries(track_srv ${catkin_LIBRARIES} ${OpenCV_LIBRARIES})
add_dependencies(track_srv ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})