
;; Turning this into a multi-arg apply-generic with raise
;; Using methods from 2.82 & 2.83

;; Define the order of types
;; Having an in-memory hash-table with index-numbers would
;; improve performance significantly
(define tower '(integer rational real complex))

;; Find and return the sequence num in the list
(define (index-in-list item lis)
  (define (iter item lis curr)
    (cond ((null? lis) -1)
          ((eq? item (car lis)) curr)
          (else (iter item (cdr lis) (+ curr 1)))))
  (iter item lis 0))

;; Given index, return item from the list
(define (item-at-index index lis)
  (cond ((or (< index 0) (null? lis)) (error "out of bound"))
        ((= index 0) (car lis))
        (else (item-at-index (- index 1) (cdr lis)))))

;; Given a list of types, find the "highest" type among them
;; which is encompassing all of the types
(define (get-highest-type types)
  (let ((max-type-index
         (fold (lambda (item acc)
                 (max (index-in-list item tower) acc))
               0
               types)))
    (item-at-index max-type-index tower)))

(define (raise-all args target-type)
  (if (null? args)
      '()
      (let ((first (car args))
            (rest (cdr args)))
        (cond
         ((null? args) '())
         ((eq? (type-tag first) target-type)
          (cons first (raise-all rest target-type)))
         (else (raise-all (cons (raise first) rest) target-type))))))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (not (all-types-same? type-tags))
              ;; checking also that both are not of the same types
              (let* ((highest-type (get-highest-type types))
                     (raised-args (raise-all args highest-type)))
                (apply apply-generic op raised-args)))))))
