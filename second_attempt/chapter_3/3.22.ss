(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))

    (define (set-front-ptr! item) (set! front-ptr item))
    (define (set-rear-ptr! item) (set! rear-ptr item))

    (define (empty-queue?) (null? front-ptr))

    (define (front-queue)
      (if (empty-queue?)
          (error "FRONT called with an empty queue")
          (car front-ptr)))

    (define (insert-queue! item)
      (let ((new-pair (cons item '())))
        (cond ((empty-queue?)
               (set-front-ptr! new-pair)
               (set-rear-ptr! new-pair)
               front-ptr)
              (else
               (set-cdr! rear-ptr new-pair)
               (set-rear-ptr! new-pair)
               front-ptr))))

    (define (delete-queue!)
      (cond ((empty-queue?)
             (error "DELETE! called with an empty queue"))
            (else
             (set-front-ptr! (cdr front-ptr))
             front-ptr)))

    (define (print)
      (display front-ptr)
      front-ptr)

    (define (dispatch m)
      (cond ((eq? m 'print) (print))
            ((eq? m 'insert) insert-queue!)
            ((eq? m 'delete) (delete-queue!))
            ((eq? m 'front) (front-queue))
            (else (error "ERROR - UNKNOWN OP"))))
    dispatch))

(define (insert-queue! queue item)
  ((queue 'insert) item))
(define (delete-queue! queue)
  (queue 'delete))
(define (front-queue queue)
  (queue 'front))
