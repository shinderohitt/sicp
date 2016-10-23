;; Exercise 2.84.  Using the raise operation of exercise 2.83, modify the
;; apply-generic procedure so that it coerces its arguments to have the
;; same type by the method of successive raising, as discussed in this
;; section. You will need to devise a way to test which of two types is
;; higher in the tower. Do this in a manner that is ``compatible'' with
;; the rest of the system and will not lead to problems in adding new
;; levels to the tower.


;; list defining the tower type sequence
;; a type to the left is a subtype of any type
;; complex is the supertype of all
(define type-tower '(scheme-number rational real complex))

;; returns the type higher among the two
(define (higher-type type1 type2 tower)
  (cond ((null? tower) (error "Invalid types or tower provided"))
        ((equal? (car tower) type1) type2)
        ((equal? (car tower) type2) type1)
        (else (higher-type type1 type2 (cdr tower)))))

(define (make-same x1 x2)
  (let ((type1 (type-tag x1))
        (type2 (type-tag x2)))
    (if (equal? type1 type2)
        (cons x1 x2)
        (if (equal? (higher-type type1 type2 type-tower) type1)
            (make-same x1 (raise x2))
            (make-same (raise x1) x2)))))

;; This takes advantage of the raise to coerce the type
;; of a lower argument to be same as the higher one
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((args (make-same (car args) (cadr args))))
                (apply-generic op (car args) (cadr args)))
              (error "No method for these types"
                     (list op type-tags)))))))
