
(cl:in-package :asdf)

(defsystem "move_demo-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "CamToReal" :depends-on ("_package_CamToReal"))
    (:file "_package_CamToReal" :depends-on ("_package"))
    (:file "FindNearestModel" :depends-on ("_package_FindNearestModel"))
    (:file "_package_FindNearestModel" :depends-on ("_package"))
    (:file "GraspObj" :depends-on ("_package_GraspObj"))
    (:file "_package_GraspObj" :depends-on ("_package"))
    (:file "TrackObj" :depends-on ("_package_TrackObj"))
    (:file "_package_TrackObj" :depends-on ("_package"))
  ))