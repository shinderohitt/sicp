;; Ripple carry adder circuit generator
(define (ripple-carry-adder Ak Bk Sk C)
  (define (iter Ak Bk Sk c-in)
    (if (null? Ak) 'ok
        (let ((a (car Ak))
              (b (car Bk))
              (s (car Sk))
              (c (make-wire)))
          (full-adder a b c-in s c)
          (iter (cdr Ak) (cdr Bk) (cdr Sk) c))))
  (iter Ak Bk Sk C))
