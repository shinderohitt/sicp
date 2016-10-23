;; Exercise 2.82.  Show how to generalize apply-generic to handle
;; coercion in the general case of multiple arguments. One strategy is to
;; attempt to coerce all the arguments to the type of the first argument,
;; then to the type of the second argument, and so on. Give an example of
;; a situation where this strategy (and likewise the two-argument version
;; given above) is not sufficiently general. (Hint: Consider the case
;; where there are some suitable mixed-type operations present in the
;; table that will not be tried.)


(define (no-method op type-tags)
  (error "No method for these types"
         (list op type-tags)))

(define (can-all-be-coerced all-types target-type)
  (and (map
        (lambda (type)
          (or (equal? target-type type)
              (get-coercion type target-type)))
        all-types)))

(define (right-target-type all-types)
  (let ((right-types
         (filter
          (lambda (target-type)
            (can-all-be-coerced all-types target-type))
          all-types))))
  (if (> (length right-types) 0)
      (car right-types)
      (error "No one type exists to convert all args to")))

(define (coerce-all args target-type)
  (map
   (lambda (arg)
     (if (equal? target-type (type-tag arg))
         arg
         ((get-coercion (type-tag arg) target-type) arg)))
   args))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (let ((target-type (right-target-type type-tags)))
            (apply-generic (list op (coerce-all args target-type))))))))

;; The solution above assumes that processing multiple arguments
;; is handled at the packages which handle the proc operations
