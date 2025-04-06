#!/usr/bin/env python3
import rospy
from move_demo.srv import FindNearestModel, FindNearestModelResponse
from gazebo_msgs.srv import GetWorldProperties, GetModelState
import math

def handle_find_nearest_model(req):
    rospy.wait_for_service('/gazebo/get_world_properties')
    try:
        get_world_properties = rospy.ServiceProxy('/gazebo/get_world_properties', GetWorldProperties)
        world_properties = get_world_properties()
        
        nearest_model_name = ""
        min_distance = float('inf')
        
        for model_name in world_properties.model_names:
            # print(model_name)
            if model_name != "ground_plane" and model_name != "jackal" and model_name != "smart_house_2"  and model_name != "husky" and model_name != "polaris_ranger_ev" and model_name != "person_standing" and model_name != "Construction Cone":
                print(model_name)
                get_model_state = rospy.ServiceProxy('/gazebo/get_model_state', GetModelState)
                model_state = get_model_state(model_name, "world")
                
                distance = math.sqrt((model_state.pose.position.x - req.x) ** 2 +
                                     (model_state.pose.position.y - req.y) ** 2 + 
                                     (model_state.pose.position.z - req.z) ** 2 
                                     )
                                     
                if distance < min_distance:
                    min_distance = distance
                    nearest_model_name = model_name

                    # print(nearest_model_name)
                    
        return FindNearestModelResponse(nearest_model_name)
        
    except rospy.ServiceException as e:
        print("Service call failed: %s" % e)

def find_nearest_model_server():
    rospy.init_node('find_nearest_model_server')
    s = rospy.Service('find_nearest_model', FindNearestModel, handle_find_nearest_model)
    print("Ready to find nearest model.")
    rospy.spin()

if __name__ == "__main__":
    find_nearest_model_server()
