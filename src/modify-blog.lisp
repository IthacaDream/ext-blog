;;;; ext-blog.lisp
;;;;
;;;; This file is a part of ext-blog, a common lisp blog engine.
;;;; See file doc/LICENSE for license details.
;;;;
;;;; Author: Kevin Lynx (kevinlynx at gmail dot com)
(in-package #:ext-blog)

(export '(start))

(defparameter *access-log-path* 
  (and *enable-log* (merge-pathnames "ext-blog-access.log" *log-path*)))
(defparameter *message-log-path* 
  (and *enable-log* (merge-pathnames "ext-blog-message.log" *log-path*)))

(defun create-log-path ()
  (when *enable-log*
    (ensure-directories-exist *access-log-path*)
    (ensure-directories-exist *message-log-path*)))

(defclass ext-blog-acceptor (restas:restas-acceptor)
  ()
  (:default-initargs
   :access-log-destination *access-log-path*
   :message-log-destination *message-log-path*))

(defun main() 
  (format t "begin main, path=~a~%" *post-store-path*)

  (let ((posts (load-posts)))
    (format t "posts: ~d~%" (list-length posts))
    (loop for post in posts
       do (when (= 1 (slot-value post 'id))
	    (format t "id: ~d~%title: ~a~%time: ~d~%" 
		    (slot-value post 'id) 
		    (slot-value post 'title) 
		    (slot-value post 'time))
	    (setf (slot-value post 'time) (encode-universal-time 27 2 22 1 6 2015))))
    (store-posts posts))
  (format t "end main~%")
)
