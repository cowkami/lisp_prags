(ql:quickload "usocket")

(defun create-client (port)
  (let ((socket (usocket:socket-connect "127.0.0.1" port :element-type 'character)))
    (unwind-protect
      (progn
        (usocket:wait-for-input socket)
        (format t "~A~%" (read-line (usocket:socket-stream socket))))
      (usocket:socket-close socket))))


(defparameter my-stream (usocket:socket-connect "127.0.0.1" 4444 :element-type 'character))

(defun read-socket (socket)
  (progn
    (usocket:wait-for-input socket)
    (format t "~A~%" (read-line (usocket:socket-stream socket)))))

(defun send-message (connection message)
  (progn
    (format (usocket:socket-stream connection) message)
    (force-output (usocket:socket-stream connection))))
