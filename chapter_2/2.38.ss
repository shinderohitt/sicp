;; The accumulate procedure is also known as fold-right,
;; because it combines the first element of the sequence with
;; the result of combining all the elements to the right.
;; There is also a fold-left, which is similar to fold-right,
;; except that it combines elements working in the opposite direction:

;; (following is the same old accumulate)
;; (define (fold-right op initial sequence)
;;   (if (null? sequence)
;;       initial
;;       (op (car sequence)
;;           (accumulate op initial (cdr sequence)))))

;; (define (fold-left op initial sequence)
;;   (define (iter result rest)
;;     (if (null? rest)
;;         result
;;         (iter (op result (car rest))
;;               (cdr rest))))
;;   (iter initial sequence))

;; What are the values of
(fold-right / 1 (list 1 2 3)) ;; 3/2
(fold-left / 1 (list 1 2 3)) ;; 1/6
(fold-right list '() (list 1 2 3)) ;; (1 (2 (3)))
(fold-left list '() (list 1 2 3)) ;; (((1) 2) 3)

;; *, + operations are commutative. they will produce the same
;; values no matter in what order we apply them.
(fold-right * 1 '(1 2 3 4 5)) ;; 120
(fold-left * 1 '(1 2 3 4 5))  ;; 120
