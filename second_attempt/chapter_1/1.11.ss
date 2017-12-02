;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 1.11.  A function f is defined by the rule that f(n) = n if ;;
;; n<3 and f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) if n> 3. Write a     ;;
;; procedure that computes f by means of a recursive process. Write a   ;;
;; procedure that computes f by means of an iterative process.          ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; f(n) = n if n<3 and
;; f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) if n> 3

(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1))
         (* 2 (f (- n 2)))
         (* 3 (f (- n 3))))))

(f 1)
;Value: 1

(f 2)
;Value: 2

(f 3)
;Value: 4

(f 4)
;Value: 11

(f 5)
;Value: 25


;; Iterative version, blatantly copied from
;; http://community.schemewiki.org/?sicp-ex-1.11
(define (f n)
  (define (iter a b c count)
    (if (= count 0)
        a
        (iter b c (+ c (* 2 b) (* 3 a)) (- count 1))))
  (iter 0 1 2 n))
