(define (make-point x y) (cons x y))
(define (x-point x) (car x))
(define (y-point x) (cdr x))

(define (make-segment p1 p2) (cons p1 p2))
(define (start-segment p) (car p))
(define (end-segment p) (cdr p))

(define (average x y) (/ (+ x y) 2))
(define (midpoint-segment s)
  (make-point
   (average (x-point (start-segment s))
            (x-point (end-segment s)))
   (average (y-point (start-segment s))
            (y-point (end-segment s)))))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define a (make-point -1 2))
(define b (make-point 3 -6))
(define s (make-segment a b))
(define m (midpoint-segment s))

(print-point m)

;; (1,2)

;; Test code from
;; http://www.billthelizard.com/2010/09/sicp-22-line-segments-in-plane.html
