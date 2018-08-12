
;; a
(define (integrate-series s)
   (stream-map (lambda (int coeff) (* (/ 1 int) coeff))
               (stream-cdr integers) ;; stream of integers
               s))

;; b
(define cosine-series
  (cons-stream 1 (integrage-series sine-series)))
