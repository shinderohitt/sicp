
(define (same-parity . w)
  (if (or (null? w)
          (null? (cdr w)))
      w
      (cons (car w) (apply same-parity (cddr w)))))

(same-parity 2 3 4 5 6 7)
;; (2 4 6)
