(asdf:oos 'asdf:load-op :cl-store)
;(asdf:load-system :cl-store)

(defvar *data-root* "/home/work/online/data/")
(defvar *store-path* (merge-pathnames "store/" *data-root*))
(defvar *post-store-path* (merge-pathnames "posts.store" *store-path*))

(defclass post ()
  ((id :initform nil
       :initarg :id
       :accessor post-id)
   (time :initform nil
         :initarg :time
         :accessor post-time)
   (revised-time :initform nil
                 :accessor post-revised-time)
   (title :initform nil
          :initarg :title
          :accessor post-title)
   (content :initform nil
            :initarg :content
            :accessor post-content))
  (:documentation "A post object is also called an entry."))


(defgeneric store-posts (posts))

(defgeneric load-posts ())

(defmethod store-posts (posts)
 (let ((path *post-store-path*))
   (ensure-directories-exist path)
   (cl-store:store posts path)))

(defmethod load-posts ()
 (let ((path *post-store-path*))     
   (when (probe-file path)
     (cl-store:restore path))))



(defun main() 
  (format t "begin main~%")
  (load-posts)
  (format t "end main~%")
)