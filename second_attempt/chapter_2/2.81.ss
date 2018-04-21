;; a. Louis's changes make apply-generic an infinite recursive function
;; Checking if the operation is present or not and quitting is necessary,
;; if not, we will be calling apply-generic recursively, and trying to
;; convert the same operands to their respective types again and again..

;; b. No. No changes were necessary.

;; c. Sure.

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (and (not (eq? (car type-tags) (cdr type-tags)))
                   ;; checking also that both are not of the same types
               (= (length args) 2))
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (let ((t1->t2 (get-coercion type1 type2))
                      (t2->t1 (get-coercion type2 type1)))
                  (cond (t1->t2
                         (apply-generic op (t1->t2 a1) a2))
                        (t2->t1
                         (apply-generic op a1 (t2->t1 a2)))
                        (else
                         (error "No method for these types"
                                (list op type-tags))))))
              (error "No method for these types"
                     (list op type-tags)))))))
