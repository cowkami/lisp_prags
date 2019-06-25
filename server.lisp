(ql:quickload "usocket")

(defun create-server (port)
  (let* ((socket (usocket:socket-listen "127.0.0.1" port))
         (connection (usocket:socket-accept socket :element-type 'character)))
    (unwind-protect
      (progn
        (format (usocket:socket-stream connection) "Hello World~%")
        (force-output (usocket:socket-stream connection)))
      (progn
        (format t "Closing sockets~%")
        (usocket:socket-close connection)
        (usocket:socket-close socket)))))

(defparameter my-socket (usocket:socket-listen "127.0.0.1" 4444))
(defparameter my-stream (usocket:socket-accept my-socket :element-type 'character))

(defun send-message (connection message)
  (progn
    (format (usocket:socket-stream connection) message)
    (force-output (usocket:socket-stream connection))))

(defun read-socket (socket)
  (progn
    (usocket:wait-for-input sokect)
    (format -t "~A~%" (read-line (usocket:socket-stream socket)))))
