;; Exercise 2.41.  Write a procedure to find all ordered triples of
;; distinct positive integers i, j, and k less than or equal to a given
;; integer n that sum to a given integer s.


(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (ints-equal-to x)
  (lambda (ints)
    (= (apply + ints) x)))

(define (unique-triplets n)
  (flatmap
   (lambda (i)
     (flatmap (lambda (j)
            (map (lambda (k)
                   (list i j k))
                 (enumerate-interval 1 (- j 1))))
          (enumerate-interval 1 (- i 1))))
   (enumerate-interval 1 n)))

(define (uniqe-tripets-under-and-equal n x)
  (filter (ints-equal-to x)
          (unique-triplets n)))

(uniqe-tripets-under-and-equal 5 10)
;; ((5 3 2) (5 4 1))
