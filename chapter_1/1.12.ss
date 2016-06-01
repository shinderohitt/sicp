
;; Exercise 1.12
;; Calculate a number in Pascal's triangle.
;; The exact problem statement is different, and ambiguous indicating
;; that the procedure should compute "numbers" and not a number.
;; Being at the stage where you could just return a single number, or
;; a boolean value it's hard to think of a way to return multiple values.
;; I did look up the solution after running out of ideas and below is the
;; re-implementation of the same idea

;; We don't return multiple numbers, it's just a single number in the triangle
;; What it expects is a row, and the column number which provides procedure
;; the location of the number in the triangle.

;; The idea is simple, in Pascal's triangle, every number is a sum of two
;; numbers above it. Except for the numbers at the edges of the triangle.

(define (pascal row column)
  (cond ((= column 1) 1) ;; first column (edge of the triangle; always 1)
        ((= row column) 1) ;; last column (edge; always 1)
        ((> column row) #f) ;; no use actually (unless given wrong inputs)
        (else (+ (pascal (- row 1) (- column 1)) ;; sum of above two numbers
                 (pascal (- row 1) column)))))
(pascal 20 10)

;; This is a recursive procedure, once you call it with a valid row and
;; column, it recursively calculates the value of the numbers above given
;; location until our base conditions (= column 1) or (= row column)
;; are reached, from then onwards, in reverse manner it calculates the
;; sum of each location required to calculate the value of the given position.
