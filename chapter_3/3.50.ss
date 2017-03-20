;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 3.50.  Complete the following definition, which generalizes   ;;
;; stream-map to allow procedures that take multiple arguments, analogous ;;
;; to map in section 2.2.3, footnote 12.                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map (lambda (x) (car x)) argstreams))
       (apply stream-map
              (cons proc (map (lambda (x) (cdr x)) argstreams))))))
