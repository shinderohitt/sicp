
;; 2.1 a better version of make-rat, which handles signs as well

(define (print-rat x)
  (newline)
  (display (car x))
  (display "/")
  (display (cdr x)))

(define (make-rat n d)
  (let ((g (gcd n d))
        (n (if (or (and (negative? n)
                        (positive? d))
                   (and (positive? n)
                        (negative? d)))
               (if (< n 0) n (- 0 n))
               (abs n)))
        (d (abs d)))
    (cons (/ n g)
          (/ d g))))

(define x (make-rat 5 -6))

(print-rat x)

;; That above is my silly solution. A clever one is below
(define (make-rat n d)
  (let ((g (gcd n d)))
    (if (< d 0)
        (cons (/ (* n -1) g) (/ (* d -1) g))
        (cons (/ n g) (/ d g)))))
;; Source: http://www.billthelizard.com/2010/09/sicp-21-rational-numbers.html
