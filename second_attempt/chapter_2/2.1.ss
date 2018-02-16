(define (make-rat n d)
  (let ((g (gcd n d)))
    (if (or (and (< n 0) (< d 0))
            (and (> n 0) (> d 0)))
        ;; if both n & d are either positive or negative
        (cons (/ n g) (/ d g))
        ;; if either one of them is negative, set n negative
        (cons (- (abs (/ n g))) ( abs (/ d g))))))
