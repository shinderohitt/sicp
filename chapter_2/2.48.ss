;; A directed line segment in the plane can be represented as a pair of vectors
;; -- the vector running from the origin to the start-point of the segment,
;; and the vector running from the origin to the end-point of the segment.
;; Use your vector representation from exercise 2.46 to define a representation
;; for segments with a constructor make-segment and selectors start-segment
;; and end-segment.

(define (make-vect x-cor y-cor) (cons x-cor y-cor))
(define (x-cor vect) (car vect))
(define (y-cor vect) (cdr vect))

(define make-segment cons)
(define start-segment car)
(define end-segment cdr)
