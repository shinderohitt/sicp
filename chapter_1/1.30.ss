
;; the given sum procedure in the book
;; which is recursive; we are supposed to write an interative one

;; recursive
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

;; iterative version (solution)
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ (term a) result))))
  (iter a 0))

;; test for summing integers
(define (inc a)
  (+ a 1))
(define (identity a) a)
(define (sum-integers a b)
  (sum identity a inc b))

(sum-integers 1 10) ;; 55
