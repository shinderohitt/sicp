
;; 2.2 something like rat-numbers for line segments in a plane

(define (make-point x y) (cons x y))
(define (x-point point) (car point))
(define (y-point point) (cdr point))

(define (start-segment seg) (car seg))
(define (end-segment seg) (cdr seg))

(define (make-segment point-x point-y)
  (cons point-x point-y))

(define (midpoint-segment line-seg)
  (make-point (/ (+ (x-point (start-segment line-seg))
                    (x-point (end-segment line-seg)))
                 2)
              (/ (+ (y-point (start-segment line-seg))
                    (y-point (end-segment line-seg)))
                 2)))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")")
  (newline))

(define x (make-segment
           (make-point 2 3)
           (make-point 3 4)))

(print-point (midpoint-segment x))

;; (5/2,7/2)
