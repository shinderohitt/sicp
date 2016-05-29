;; sum of larger nums

(define (square x)
  ( * x x))
(define (sum-of-squares x x)
  (+ (square x) (square x)))
(define (sum-of-larger-nums a b c)
  (cond ((and (< a b) (< a c)) (sum-of-squares b c))
        ((and (< b a) (< b c)) (sum-of-squares a c))
        (else (sum-of-squares a b))))

(sum-of-larger-nums 1 4 2)

