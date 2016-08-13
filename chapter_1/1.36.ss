;; Exercise 1.36

(define tolerance 0.00001)
(define (average x y) (/ (+ x y) 2))
(define (fixed-point f first-guess)
  (define (close-enough v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try-guess guess)
    (let ((next (f guess)))
      (display next)
      (display "\n")
      (if (close-enough guess next)
          next
          (try-guess next))))
  (try-guess first-guess))


;; Find x^x = 1000 by finding a fixed-point of
;; x -> log(1000)/log(x)


(fixed-point (lambda (x) (average x (/ (log 1000) (log x))))
             1.1)


;; prints

;; 36.78828689214517
;; 19.352175531882512
;; 10.84183367957568
;; 6.870048352141772
;; 5.227224961967156
;; 4.701960195159289
;; 4.582196773201124
;; 4.560134229703681
;; 4.5563204194309606
;; 4.555669361784037
;; 4.555558462975639
;; 4.55553957996306
;; 4.555536364911781

;; ;Value: 4.555536364911781
