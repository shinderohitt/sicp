(define (stream-limit s tolerance)
  (let ((s1 (stream-car s))
        (s2 (stream-car (stream-cdr s))))
    (if (< tolerance (abs (- s1 s2)))
        s2
        (stream-limit (stream-cdr s) tolerance))))
