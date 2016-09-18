;; Complete the following definitions of reverse
;; (exercise 2.18) in terms of fold-right and fold-left from exercise 2.38:

;; (define (reverse sequence)
;;   (fold-right (lambda (x y) <??>) nil sequence))
;; (define (reverse sequence)
;;   (fold-left (lambda (x y) <??>) nil sequence))


(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))


(define (reverse sequence)
  (fold-right (lambda (x y)
                (if (null? y)
                    (cons x y)
                    (cons (car y)
                          (cons x (cdr y)))))
              '()
              sequence))
(reverse '(1 2 3)) ;; (3 2 1)


(define (reverse sequence)
  (fold-left (lambda (x y) (cons y x)) '() sequence))
(reverse '(1 2 3)) ;; (3 2 1)
