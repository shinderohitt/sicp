
;; 1.9
;; This might seem a little weird, coming from other languages.
;; I tried to run this snippet from 1.9, but it somehow fell into
;; an infinite loop or something. Initially I thought that if I evaluate
;; `inc` and `dec` before evaluating the `+`, they would end up using
;; the primitive operator instead of this later-defined procedure `+`.
;; I think I was wrong, the `+` defined later seem being used even by
;; `inc` and `dec` which is causing the execution flow to fall into a loop.
;; To test this, I renamed `+` procedure name to `plus` and it worked
;; without any other changes.

(define (inc x)
  (+ x 1))
(define (dec y)
  (- y 1))

(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))
(+ 3 2)

;; Substitution model (Which is a recursive procedure - expands and reduces)
;; (+ 3 2)
;; (inc (+ 2 2))
;; (inc (inc (+ 1 2)))
;; (inc (inc (inc (+ 0 2))))
;; (inc (inc (inc 2)))
;; (inc (inc 3))
;; (inc 4)
;; 5

(define (+ a b)
  (if (= a 0)
      b
      (+ (dec a) (inc b))))
(+ 3 2)

;; Iterative procedure
;; (+ 3 2)
;; (+ 2 3)
;; (+ 1 4)
;; (+ 0 5)
;; 5
