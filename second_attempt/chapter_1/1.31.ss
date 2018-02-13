(define (mul term a next b)
  (if (> a b)
      1
      (* (term a)
         (mul term (next a) next b))))

;;;; iterative version of mul above
;; (define (mul term a next b)
;;   (define (iter a result)
;;     (if (> a b)
;;         result
;;         (iter (next a) (* result (term a)))))
;;   (iter a 1))

(define (factorial n)
  (mul (lambda (x) x) 1 (lambda (x) (+ x 1)) n))

(define (inc x) (+ 1 x))
(define (inc-if-true f)
  (lambda (x)
    (if (f x) (inc x) x)))
(define (pi-est n)
  (* (exact->inexact
      (/ (mul (inc-if-true odd?) 2 inc n)
         (mul (inc-if-true even?) 2 inc n)))
     4))

(pi-est 1000)
;Value: 3.1400238186005973
