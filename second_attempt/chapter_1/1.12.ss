;; Exercise 1.12.  The following pattern of numbers is called Pascal's
;; triangle.

;; The numbers at the edge of the triangle are all 1, and each number
;; inside the triangle is the sum of the two numbers above it.35 Write a
;; procedure that computes elements of Pascal's triangle by means of a
;; recursive process.

(define (pascal row col)
   (if (or (= col 1) (= col row))
       1
       (+ (pascal (- row 1) (- col 1))
          (pascal (- row 1) col))))
