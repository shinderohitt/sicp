;; Exercise 1.18.  Using the results of exercises 1.16 and 1.17, devise a
;; procedure that generates an iterative process for multiplying two
;; integers in terms of adding, doubling, and halving and uses a
;; logarithmic number of steps.40


(define (halve n)
  (/ n 2))
(define (double n)
  (+ n n))

(define (* a b)
  (define (mult-iter a b sum)
    (if (= 0 b)
        sum
        (if (even? b)
            (mult-iter (double a) (halve b) sum)
            (mult-iter a (- b 1) (+ sum a)))))

  (mult-iter a b 0))

(* 3 5) ;; 15
