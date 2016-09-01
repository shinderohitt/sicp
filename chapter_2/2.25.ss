
;; Give combinations of cars and cdrs that will
;; pick 7 from each of the following lists:

(define x '(1 3 (5 7) 9))
(display (car (cdr (car (cddr x)))))

(define y '((7)))
(display (caar y))

(define z '(1 (2 (3 (4 (5 (6 7)))))))
(display (car
          (cdr
           (car
            (cdr
             (car
              (cdr
               (car
                (cdr
                 (car
                  (cdr
                   (car
                    (cdr z)))))))))))))
;; Better way to do this?
;; Probably write a procedure
;; Otherwise I do not know
