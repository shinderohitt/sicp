;; if types is an empty list, we return #t since there are no types
(define (all-types-same? types)
  (if (null? types)
      #t
      (let ((first (car types)))
        (fold (lambda (x y) (and y (eq? x first))) true types))))

;; This creates a list of lists.
;; Inner lists being the coersion-functions
;; For each type, we check if others can be converted to it
;; and if it is so, we return such a list of coercion functions
(define (coercion-types types)
  (define (filter-missing list-of-method-list)
    (filter and #t list-of-method-list))
  (let* ((coerce-all
          (map (lambda (type)
                 (map (lambda (inner-type)
                        (get-coercion type inner-type)) types))
               types))
         (possible-candidates (filter-missing coerce-all)))
    (if (null? possible-candidates)
        #f
        (car possible-candidates))))

(define (apply-multi proc-list arg-list)
  (map (lambda (f a) (f a)) proc-list arg-list))

;; This assumes that we have type-coerce methods for each type ot itself
;; for eg,
;; (define (scheme-number->scheme-number n) n)
;; (define (complex->complex z) z)
;; (put-coercion 'scheme-number 'scheme-number
;;               scheme-number->scheme-number)
;; (put-coercion 'complex 'complex complex->complex)

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (not (all-types-same? type-tags))
              ;; checking also that both are not of the same types
              (let ((coercion-procs (coercion-types types)))
                (if (not (coercion-procs))
                    (error "No method for these types")
                    (let ((new-args (apply-multi coercion-procs args)))
                      (apply apply-generic op new-args)))))))))
