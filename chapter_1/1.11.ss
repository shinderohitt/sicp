;; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.


;; fibonacci series recursive procedure
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))
(fib 6)

;; iterative method
(define (fib2 count)
  (fib-iter 0 1 count))
(define (fib-iter a b count)
  (if (= count 0)
      a
      (fib-iter b
                (+ a b)
                (- count 1))))
(fib2 1)


;; exercise 1.11
;; A function f is defined by the rule that
;; f(n) = n if n<3 and f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) if n> 3.
;; Write a procedure that computes f by means of a recursive process.
;; Write a procedure that computes f by means of an iterative process.


;; recursive procedure
(define (fn n)
  (if (< n 3)
      n
      (+ (fn (- n 1))
         (* 2 (fn (- n 2)))
         (* 3 (fn (- n 3))))))
(fn 7) ;; 142


;; Iterative version
;; I wonder how any practical programs can be written
;; with these (((((()))))) it's crazy!
(define (fn-iter limit)
  (fn2 0 1 2 limit))

(define (fn2 a b c limit)
  (if (= limit 0)
      a
      (fn2 b c (+ (* 3 a)
                  (* 2 b)
                  c)
           (- limit 1))))

(fn-iter 7) ;; 142
