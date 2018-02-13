
(define (cube x) (* x x x))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

(integral cube 0 1 0.01)


;; sum of numbers 1 to 10.
(sum (lambda (x) x) 1 (lambda (x) (+ x 1)) 10)

(define (simpsons f a b n)
  (define h (/ (- b a) n))
  (define (next-y k) (f (+ a (* k h))))
  (* (sum f a next-y b)
     (/ h 3)))
(simpsons cube 0 1 100)
