;; Write a procedure to find all ordered triples of distinct positive
;; integers i, j, and k less than or equal to a given integer n that
;; sum to a given integer s.

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))

(define (triple-sum triple)
  (+ (car triple)
     (car (cdr triple))
     (car (cddr triple))))


(define (ordered-triples n equal-to)
  (filter (lambda (x) (= equal-to (triple-sum x)))
          (flatmap (lambda (x)
                     (flatmap (lambda (y)
                                (map (lambda (z) (list z y x))
                                     (enumerate-interval 1 (- y 1))))
                              (enumerate-interval 1 (- x 1))))
                   (enumerate-interval 1 n))))

(ordered-triples 4 6) ;; ((1 2 3))
