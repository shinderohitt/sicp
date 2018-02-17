;; Exercise 2.9.  The width of an interval is half of the difference
;; between its upper and lower bounds. The width is a measure of the
;; uncertainty of the number specified by the interval. For some
;; arithmetic operations the width of the result of combining two
;; intervals is a function only of the widths of the argument intervals,
;; whereas for others the width of the combination is not a function of
;; the widths of the argument intervals. Show that the width of the sum
;; (or difference) of two intervals is a function only of the widths of
;; the intervals being added (or subtracted). Give examples to show that
;; this is not true for multiplication or division.

(define (make-interval a b) (cons a b))
(define (upper-bound i) (car i))
(define (lower-bound i) (cdr i))


(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (lower-bound y))
                 (- (upper-bound x) (upper-bound y))))

(define (interval-width i)
  (/ (abs (- (upper-bound i) (lower-bound i))) 2.0))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))


(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

(define x (make-interval 5 10))
(define y (make-interval 10 20))
(interval-width x) ;; 2.5
(interval-width y) ;; 5

(interval-width (add-interval x y)) ;; 7.5 addition
(interval-width (sub-interval y x)) ;; 2.5 subtraction
(interval-width (mul-interval y x)) ;; 75 ?
(interval-width (div-interval y x)) ;; 1.5 ?
