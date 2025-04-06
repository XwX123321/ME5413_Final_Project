; Auto-generated. Do not edit!


(cl:in-package move_demo-srv)


;//! \htmlinclude TrackObj-request.msg.html

(cl:defclass <TrackObj-request> (roslisp-msg-protocol:ros-message)
  ((obj
    :reader obj
    :initarg :obj
    :type cl:string
    :initform ""))
)

(cl:defclass TrackObj-request (<TrackObj-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TrackObj-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TrackObj-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name move_demo-srv:<TrackObj-request> is deprecated: use move_demo-srv:TrackObj-request instead.")))

(cl:ensure-generic-function 'obj-val :lambda-list '(m))
(cl:defmethod obj-val ((m <TrackObj-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader move_demo-srv:obj-val is deprecated.  Use move_demo-srv:obj instead.")
  (obj m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TrackObj-request>) ostream)
  "Serializes a message object of type '<TrackObj-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'obj))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'obj))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TrackObj-request>) istream)
  "Deserializes a message object of type '<TrackObj-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'obj) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'obj) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TrackObj-request>)))
  "Returns string type for a service object of type '<TrackObj-request>"
  "move_demo/TrackObjRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TrackObj-request)))
  "Returns string type for a service object of type 'TrackObj-request"
  "move_demo/TrackObjRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TrackObj-request>)))
  "Returns md5sum for a message object of type '<TrackObj-request>"
  "d6d04e8b2c20037b11fd9c862b657664")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TrackObj-request)))
  "Returns md5sum for a message object of type 'TrackObj-request"
  "d6d04e8b2c20037b11fd9c862b657664")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TrackObj-request>)))
  "Returns full string definition for message of type '<TrackObj-request>"
  (cl:format cl:nil "string obj~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TrackObj-request)))
  "Returns full string definition for message of type 'TrackObj-request"
  (cl:format cl:nil "string obj~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TrackObj-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'obj))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TrackObj-request>))
  "Converts a ROS message object to a list"
  (cl:list 'TrackObj-request
    (cl:cons ':obj (obj msg))
))
;//! \htmlinclude TrackObj-response.msg.html

(cl:defclass <TrackObj-response> (roslisp-msg-protocol:ros-message)
  ((result
    :reader result
    :initarg :result
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass TrackObj-response (<TrackObj-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TrackObj-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TrackObj-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name move_demo-srv:<TrackObj-response> is deprecated: use move_demo-srv:TrackObj-response instead.")))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <TrackObj-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader move_demo-srv:result-val is deprecated.  Use move_demo-srv:result instead.")
  (result m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TrackObj-response>) ostream)
  "Serializes a message object of type '<TrackObj-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'result) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TrackObj-response>) istream)
  "Deserializes a message object of type '<TrackObj-response>"
    (cl:setf (cl:slot-value msg 'result) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TrackObj-response>)))
  "Returns string type for a service object of type '<TrackObj-response>"
  "move_demo/TrackObjResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TrackObj-response)))
  "Returns string type for a service object of type 'TrackObj-response"
  "move_demo/TrackObjResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TrackObj-response>)))
  "Returns md5sum for a message object of type '<TrackObj-response>"
  "d6d04e8b2c20037b11fd9c862b657664")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TrackObj-response)))
  "Returns md5sum for a message object of type 'TrackObj-response"
  "d6d04e8b2c20037b11fd9c862b657664")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TrackObj-response>)))
  "Returns full string definition for message of type '<TrackObj-response>"
  (cl:format cl:nil "bool result~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TrackObj-response)))
  "Returns full string definition for message of type 'TrackObj-response"
  (cl:format cl:nil "bool result~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TrackObj-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TrackObj-response>))
  "Converts a ROS message object to a list"
  (cl:list 'TrackObj-response
    (cl:cons ':result (result msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'TrackObj)))
  'TrackObj-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'TrackObj)))
  'TrackObj-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TrackObj)))
  "Returns string type for a service object of type '<TrackObj>"
  "move_demo/TrackObj")