;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 3.25.  Generalizing one- and two-dimensional tables, show how ;;
;; to implement a table in which values are stored under an arbitrary     ;;
;; number of keys and different values may be stored under different      ;;
;; numbers of keys. The lookup and insert! procedures should take as      ;;
;; input a list of keys used to access the table.                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (make-table)
  (let ((local-table (list '*table*)))

    (define (lookup keys)
      (define (helper keys table)
        (if (or (null? keys) (null? table))
            false
            (let ((key (car keys))
                  (subtable (assoc (car keys) (cdr table))))
              (if subtable
                  (if (eq? (length keys) 1)
                      (cdr subtable)
                      (helper (cdr keys) subtable))
                  false))))
      (helper keys local-table))

    (define (insert! keys value)
      (define (build-nested-tables keys value)
        ;; (key1 (key2 (key3 (key4 . value))))
        (cond ((null? keys) value)
              ((eq? 1 (length keys))
               (cons (car keys) value))
              (else
               (list (car keys)
                     (build-nested-tables (cdr keys) value)))))
      (define (helper keys value table)
        (let ((subtable (assoc (car keys) (cdr table))))
          (if subtable
              (if (eq? 1 (length keys))
                  (if (pair? subtable)
                      (set-cdr! subtable value)
                      (set-cdr! subtable
                                (cons (cons (car keys) value)
                                      (cdr subtable))))
                  (helper (cdr keys) value subtable))
              (begin
                (set-cdr! table
                          (cons (build-nested-tables keys value)
                                (cdr table)))
                'ok))))

      (helper keys value local-table))

    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

(put '(foo bar baz) 1)
(get '(foo bar baz)) ;; 1
(put '(foo bar baz) 'apple)
(get '(foo bar baz)) ;; apple
