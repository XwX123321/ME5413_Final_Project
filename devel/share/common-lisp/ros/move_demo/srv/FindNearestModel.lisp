; Auto-generated. Do not edit!


(cl:in-package move_demo-srv)


;//! \htmlinclude FindNearestModel-request.msg.html

(cl:defclass <FindNearestModel-request> (roslisp-msg-protocol:ros-message)
  ((x
    :reader x
    :initarg :x
    :type cl:float
    :initform 0.0)
   (y
    :reader y
    :initarg :y
    :type cl:float
    :initform 0.0)
   (z
    :reader z
    :initarg :z
    :type cl:float
    :initform 0.0))
)

(cl:defclass FindNearestModel-request (<FindNearestModel-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <FindNearestModel-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'FindNearestModel-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name move_demo-srv:<FindNearestModel-request> is deprecated: use move_demo-srv:FindNearestModel-request instead.")))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <FindNearestModel-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader move_demo-srv:x-val is deprecated.  Use move_demo-srv:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <FindNearestModel-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader move_demo-srv:y-val is deprecated.  Use move_demo-srv:y instead.")
  (y m))

(cl:ensure-generic-function 'z-val :lambda-list '(m))
(cl:defmethod z-val ((m <FindNearestModel-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader move_demo-srv:z-val is deprecated.  Use move_demo-srv:z instead.")
  (z m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <FindNearestModel-request>) ostream)
  "Serializes a message object of type '<FindNearestModel-request>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'z))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <FindNearestModel-request>) istream)
  "Deserializes a message object of type '<FindNearestModel-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'z) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<FindNearestModel-request>)))
  "Returns string type for a service object of type '<FindNearestModel-request>"
  "move_demo/FindNearestModelRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'FindNearestModel-request)))
  "Returns string type for a service object of type 'FindNearestModel-request"
  "move_demo/FindNearestModelRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<FindNearestModel-request>)))
  "Returns md5sum for a message object of type '<FindNearestModel-request>"
  "cd680775ebeed150a97dc7d17020a53d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'FindNearestModel-request)))
  "Returns md5sum for a message object of type 'FindNearestModel-request"
  "cd680775ebeed150a97dc7d17020a53d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<FindNearestModel-request>)))
  "Returns full string definition for message of type '<FindNearestModel-request>"
  (cl:format cl:nil "# FindNearestModel.srv~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'FindNearestModel-request)))
  "Returns full string definition for message of type 'FindNearestModel-request"
  (cl:format cl:nil "# FindNearestModel.srv~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <FindNearestModel-request>))
  (cl:+ 0
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <FindNearestModel-request>))
  "Converts a ROS message object to a list"
  (cl:list 'FindNearestModel-request
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
    (cl:cons ':z (z msg))
))
;//! \htmlinclude FindNearestModel-response.msg.html

(cl:defclass <FindNearestModel-response> (roslisp-msg-protocol:ros-message)
  ((model_name
    :reader model_name
    :initarg :model_name
    :type cl:string
    :initform ""))
)

(cl:defclass FindNearestModel-response (<FindNearestModel-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <FindNearestModel-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'FindNearestModel-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name move_demo-srv:<FindNearestModel-response> is deprecated: use move_demo-srv:FindNearestModel-response instead.")))

(cl:ensure-generic-function 'model_name-val :lambda-list '(m))
(cl:defmethod model_name-val ((m <FindNearestModel-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader move_demo-srv:model_name-val is deprecated.  Use move_demo-srv:model_name instead.")
  (model_name m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <FindNearestModel-response>) ostream)
  "Serializes a message object of type '<FindNearestModel-response>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'model_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'model_name))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <FindNearestModel-response>) istream)
  "Deserializes a message object of type '<FindNearestModel-response>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'model_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'model_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<FindNearestModel-response>)))
  "Returns string type for a service object of type '<FindNearestModel-response>"
  "move_demo/FindNearestModelResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'FindNearestModel-response)))
  "Returns string type for a service object of type 'FindNearestModel-response"
  "move_demo/FindNearestModelResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<FindNearestModel-response>)))
  "Returns md5sum for a message object of type '<FindNearestModel-response>"
  "cd680775ebeed150a97dc7d17020a53d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'FindNearestModel-response)))
  "Returns md5sum for a message object of type 'FindNearestModel-response"
  "cd680775ebeed150a97dc7d17020a53d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<FindNearestModel-response>)))
  "Returns full string definition for message of type '<FindNearestModel-response>"
  (cl:format cl:nil "string model_name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'FindNearestModel-response)))
  "Returns full string definition for message of type 'FindNearestModel-response"
  (cl:format cl:nil "string model_name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <FindNearestModel-response>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'model_name))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <FindNearestModel-response>))
  "Converts a ROS message object to a list"
  (cl:list 'FindNearestModel-response
    (cl:cons ':model_name (model_name msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'FindNearestModel)))
  'FindNearestModel-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'FindNearestModel)))
  'FindNearestModel-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'FindNearestModel)))
  "Returns string type for a service object of type '<FindNearestModel>"
  "move_demo/FindNearestModel")