;; Exercise 3.52.  Consider the sequence of expressions

(define sum 0)
(define (accum x)
  (set! sum (+ x sum))
  sum)

(define seq (stream-map accum (stream-enumerate-interval 1 20)))
(define y (stream-filter even? seq))
(define z (stream-filter (lambda (x) (= (remainder x 5) 0))
                         seq))
;; (stream-ref y 7)
;; (display-stream z)

;; What is the value of sum after each of the above expressions is
;; evaluated? What is the printed response to evaluating the stream-ref
;; and display-stream expressions? Would these responses differ if we had
;; implemented (delay <exp>) simply as (lambda () <exp>) without using
;; the optimization provided by memo-proc ? Explain.


(stream-ref y 7)
;; value   - 136
;; prints  - nothing


(display-stream z)
;; value  - 210
;; prints - 10, 15, 45, 55, 105, 120, 190, 210


;; ;; helper code
;; (define (series n)
;;   (define (print-seq num acc)
;;     (newline)
;;     (display num)
;;     (display " => ")
;;     (display acc))
;;   (define (iter sum curr)
;;     (if (= n curr)
;;         (begin
;;           (print-seq curr (+ sum curr))
;;           (+ curr sum))
;;         (begin
;;           (print-seq curr (+ sum curr))
;;           (iter (+ sum curr) (+ curr 1)))))
;;   (iter 0 1))

;; (series 20)
