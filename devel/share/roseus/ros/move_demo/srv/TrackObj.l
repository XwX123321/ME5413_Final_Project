;; Auto-generated. Do not edit!


(when (boundp 'move_demo::TrackObj)
  (if (not (find-package "MOVE_DEMO"))
    (make-package "MOVE_DEMO"))
  (shadow 'TrackObj (find-package "MOVE_DEMO")))
(unless (find-package "MOVE_DEMO::TRACKOBJ")
  (make-package "MOVE_DEMO::TRACKOBJ"))
(unless (find-package "MOVE_DEMO::TRACKOBJREQUEST")
  (make-package "MOVE_DEMO::TRACKOBJREQUEST"))
(unless (find-package "MOVE_DEMO::TRACKOBJRESPONSE")
  (make-package "MOVE_DEMO::TRACKOBJRESPONSE"))

(in-package "ROS")





(defclass move_demo::TrackObjRequest
  :super ros::object
  :slots (_obj ))

(defmethod move_demo::TrackObjRequest
  (:init
   (&key
    ((:obj __obj) "")
    )
   (send-super :init)
   (setq _obj (string __obj))
   self)
  (:obj
   (&optional __obj)
   (if __obj (setq _obj __obj)) _obj)
  (:serialization-length
   ()
   (+
    ;; string _obj
    4 (length _obj)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _obj
       (write-long (length _obj) s) (princ _obj s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _obj
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _obj (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass move_demo::TrackObjResponse
  :super ros::object
  :slots (_result ))

(defmethod move_demo::TrackObjResponse
  (:init
   (&key
    ((:result __result) nil)
    )
   (send-super :init)
   (setq _result __result)
   self)
  (:result
   (&optional (__result :null))
   (if (not (eq __result :null)) (setq _result __result)) _result)
  (:serialization-length
   ()
   (+
    ;; bool _result
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _result
       (if _result (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _result
     (setq _result (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass move_demo::TrackObj
  :super ros::object
  :slots ())

(setf (get move_demo::TrackObj :md5sum-) "d6d04e8b2c20037b11fd9c862b657664")
(setf (get move_demo::TrackObj :datatype-) "move_demo/TrackObj")
(setf (get move_demo::TrackObj :request) move_demo::TrackObjRequest)
(setf (get move_demo::TrackObj :response) move_demo::TrackObjResponse)

(defmethod move_demo::TrackObjRequest
  (:response () (instance move_demo::TrackObjResponse :init)))

(setf (get move_demo::TrackObjRequest :md5sum-) "d6d04e8b2c20037b11fd9c862b657664")
(setf (get move_demo::TrackObjRequest :datatype-) "move_demo/TrackObjRequest")
(setf (get move_demo::TrackObjRequest :definition-)
      "string obj
---
bool result

")

(setf (get move_demo::TrackObjResponse :md5sum-) "d6d04e8b2c20037b11fd9c862b657664")
(setf (get move_demo::TrackObjResponse :datatype-) "move_demo/TrackObjResponse")
(setf (get move_demo::TrackObjResponse :definition-)
      "string obj
---
bool result

")



(provide :move_demo/TrackObj "d6d04e8b2c20037b11fd9c862b657664")


