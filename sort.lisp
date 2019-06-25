(defun main ()
  (format t "Welcome to the world of CommonLisp!"))


(defun randlist (n)
  (let ((lst ()))
    (dotimes (i n)
      (setf lst (cons (random 101) lst)))
    lst))


(defun insertion (n lst)
  (if lst
      (if (> n (car lst))
          (cons (car lst) (insertion n (cdr lst)))
          (cons n lst))
      (cons n nil)))

(defun i-sort (lst)
  (if (cdr lst)
      (insertion (car lst) (i-sort (cdr lst)))
      lst))


(defun extract (n fn lst)
  (if lst
      (if (funcall fn n (car lst))
          (cons (car lst) (extract n fn (cdr lst)))
          (extract n fn (cdr lst)))
      nil))

(defun q-sort (lst)
  (if lst
      (append
        (q-sort (extract (car lst) #'>= (cdr lst)))
        (cons (car lst) nil)
        (q-sort (extract (car lst) #'< (cdr lst))))
      nil))


(defun merge-lr (l r)
  (cond
    ((not l) r)
    ((not r) l)
    ((<= (car l) (car r)) (cons (car l) (merge-lr (cdr l) r)))
    ((<  (car r) (car l)) (cons (car r) (merge-lr l (cdr r))))))

(defun m-sort (lst)
  (if (cdr lst)
      (merge-lr 
        (m-sort (subseq lst 0 (floor (length lst) 2)))
        (m-sort (subseq lst (floor (length lst) 2) (length lst))))
      lst))
