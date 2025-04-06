cmake_minimum_required(VERSION 3.0.2)
project(robot_bridge_node)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  rospy
  std_msgs
)

catkin_package(

)

include_directories(
  include
  ${catkin_INCLUDE_DIRS}
)

add_executable(mbf_bridge_node src/mbf_bridge_node.cpp)
target_link_libraries(mbf_bridge_node ${catkin_LIBRARIES})
add_dependencies(mbf_bridge_node ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

install(TARGETS mbf_bridge_node
        ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
        LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
        RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
        )