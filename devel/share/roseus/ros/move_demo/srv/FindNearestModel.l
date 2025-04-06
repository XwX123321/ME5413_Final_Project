;; Auto-generated. Do not edit!


(when (boundp 'move_demo::FindNearestModel)
  (if (not (find-package "MOVE_DEMO"))
    (make-package "MOVE_DEMO"))
  (shadow 'FindNearestModel (find-package "MOVE_DEMO")))
(unless (find-package "MOVE_DEMO::FINDNEARESTMODEL")
  (make-package "MOVE_DEMO::FINDNEARESTMODEL"))
(unless (find-package "MOVE_DEMO::FINDNEARESTMODELREQUEST")
  (make-package "MOVE_DEMO::FINDNEARESTMODELREQUEST"))
(unless (find-package "MOVE_DEMO::FINDNEARESTMODELRESPONSE")
  (make-package "MOVE_DEMO::FINDNEARESTMODELRESPONSE"))

(in-package "ROS")





(defclass move_demo::FindNearestModelRequest
  :super ros::object
  :slots (_x _y _z ))

(defmethod move_demo::FindNearestModelRequest
  (:init
   (&key
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:z __z) 0.0)
    )
   (send-super :init)
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _z (float __z))
   self)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:z
   (&optional __z)
   (if __z (setq _z __z)) _z)
  (:serialization-length
   ()
   (+
    ;; float64 _x
    8
    ;; float64 _y
    8
    ;; float64 _z
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _x
       (sys::poke _x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _y
       (sys::poke _y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _z
       (sys::poke _z (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _x
     (setq _x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _y
     (setq _y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _z
     (setq _z (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(defclass move_demo::FindNearestModelResponse
  :super ros::object
  :slots (_model_name ))

(defmethod move_demo::FindNearestModelResponse
  (:init
   (&key
    ((:model_name __model_name) "")
    )
   (send-super :init)
   (setq _model_name (string __model_name))
   self)
  (:model_name
   (&optional __model_name)
   (if __model_name (setq _model_name __model_name)) _model_name)
  (:serialization-length
   ()
   (+
    ;; string _model_name
    4 (length _model_name)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _model_name
       (write-long (length _model_name) s) (princ _model_name s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _model_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _model_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass move_demo::FindNearestModel
  :super ros::object
  :slots ())

(setf (get move_demo::FindNearestModel :md5sum-) "cd680775ebeed150a97dc7d17020a53d")
(setf (get move_demo::FindNearestModel :datatype-) "move_demo/FindNearestModel")
(setf (get move_demo::FindNearestModel :request) move_demo::FindNearestModelRequest)
(setf (get move_demo::FindNearestModel :response) move_demo::FindNearestModelResponse)

(defmethod move_demo::FindNearestModelRequest
  (:response () (instance move_demo::FindNearestModelResponse :init)))

(setf (get move_demo::FindNearestModelRequest :md5sum-) "cd680775ebeed150a97dc7d17020a53d")
(setf (get move_demo::FindNearestModelRequest :datatype-) "move_demo/FindNearestModelRequest")
(setf (get move_demo::FindNearestModelRequest :definition-)
      "# FindNearestModel.srv
float64 x
float64 y
float64 z
---
string model_name
")

(setf (get move_demo::FindNearestModelResponse :md5sum-) "cd680775ebeed150a97dc7d17020a53d")
(setf (get move_demo::FindNearestModelResponse :datatype-) "move_demo/FindNearestModelResponse")
(setf (get move_demo::FindNearestModelResponse :definition-)
      "# FindNearestModel.srv
float64 x
float64 y
float64 z
---
string model_name
")



(provide :move_demo/FindNearestModel "cd680775ebeed150a97dc7d17020a53d")


