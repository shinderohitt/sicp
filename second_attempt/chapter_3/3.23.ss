(define (make-deque)
  (let ((front-ptr '())
        (rear-ptr '()))

    (define (set-front-ptr! item) (set! front-ptr item))
    (define (set-rear-ptr! item) (set! rear-ptr item))

    (define (empty-deque?) (null? front-ptr))

    (define (front-deque)
      (if (empty-deque?)
          (error "FRONT called with an empty deque")
          (caar front-ptr)))

    (define (rear-deque)
      (if (empty-deque?)
          (error "REAR called with an empty deque")
          (caar rear-ptr)))

    (define (insert-front-deque! item)
      (let ((new-pair (cons (cons item '()) '())))
        (cond ((empty-deque?)
               (set-front-ptr! new-pair)
               (set-rear-ptr! new-pair)
               item)
              (else
               ;; New pair should point to current first elem
               (set-cdr! new-pair front-ptr)
               ;; Update first item's "back" pointer to refer new element
               (set-cdr! (car front-ptr) new-pair)
               ;; Now update the front-ptr
               (set-front-ptr! new-pair)
               item))))

    (define (insert-rear-deque! item)
      (let ((new-pair (cons (cons item '()) '())))
        (cond ((empty-deque?)
               (set-front-ptr! new-pair)
               (set-rear-ptr! new-pair)
               item)
              (else
               ;; Update new pair's back pointer to point to rear-ptr
               (set-cdr! (car new-pair) rear-ptr)
               ;; Last pair/rear should point to new pair
               (set-cdr! rear-ptr new-pair)
               ;; Update rear-ptr to point to new pair
               (set-rear-ptr! new-pair)
               item))))

    (define (delete-front-deque!)
      (cond ((empty-deque?)
             (error "DELETE! called with an empty deque"))
            ((null? (cdr front-ptr))
             (set-front-ptr! '())
             (set-rear-ptr! '())
             #t)
            (else
             (set-front-ptr! (cdr front-ptr))
             (set-cdr! (car front-ptr) '())
             #t)))
    (define (delete-rear-deque!)
      (cond ((empty-deque?)
             (error "DELETE! called with an empty deque"))
            ((null? (cdar rear-ptr))
             (set-front-ptr! '())
             (set-rear-ptr! '())
             #t)
            (else
             (set-rear-ptr! (cdar rear-ptr))
             (set-cdr! rear-ptr '())
             #t)))

    (define (print)
      (map (lambda (pair)
             (display (car pair))
             (display " ")) front-ptr)
      "Deque")

    (define (dispatch m)
      (cond ((eq? m 'print) (print))
            ((eq? m 'insert-front) insert-front-deque!)
            ((eq? m 'insert-rear) insert-rear-deque!)
            ((eq? m 'delete-front) (delete-front-deque!))
            ((eq? m 'delete-rear) (delete-rear-deque!))
            (else (error "ERROR - UNKNOWN OP"))))
    dispatch))

(define (insert-front-deque! deque item)
  ((deque 'insert-front) item))
(define (insert-rear-deque! deque item)
  ((deque 'insert-rear) item))

(define (delete-front-deque! deque)
  (deque 'delete-front))
(define (delete-rear-deque! deque)
  (deque 'delete-rear))
(define (print deque)
  (deque 'print))
