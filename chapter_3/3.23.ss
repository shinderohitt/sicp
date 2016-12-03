;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 3.23.  A deque (``double-ended queue'') is a sequence in      ;;
;; which items can be inserted and deleted at either the front or the     ;;
;; rear. Operations on deques are the constructor make-deque, the         ;;
;; predicate empty-deque?, selectors front-deque and rear-deque, and      ;;
;; mutators front-insert-deque!, rear-insert-deque!, front-delete-deque!, ;;
;; and rear-delete-deque!. Show how to represent deques using pairs, and  ;;
;; give implementations of the operations.23 All operations should be     ;;
;; accomplished in (1) steps.                                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; This one looked quite easy at first, but all operations had to be O(1)
;; Hense, doubly linked list. I had to refer solutions before I could solve.


(define (make-deque)
  (let ((front-ptr '())
        (rear-ptr '()))
    (define (set-front-ptr! item) (set! front-ptr item))
    (define (set-rear-ptr! item) (set! rear-ptr item))
    (define (empty-deque?) (null? front-ptr))
    (define (front-deque)
      (if (not (empty-deque?))
          (caar front-ptr)
          "The deque is empty!"))

    (define (rear-deque)
      (if (not (empty-deque?))
          (caar rear-ptr)
          "The deque is empty!"))

    (define (insert-front-deque! item)
      (let ((new-pair
             (cons (cons item '()) '())
             ))
        (cond ((empty-deque?)
               (set-front-ptr! new-pair)
               (set-rear-ptr! new-pair))
              (else
               (set-cdr! new-pair front-ptr)
               (set-cdr! (car front-ptr) new-pair)
               (set-front-ptr! new-pair)
               dispatch))))

    (define (insert-rear-deque! item)
      (let ((new-pair
             (cons (cons item '()) '())
             ))
        (cond ((empty-deque?)
               (set-front-ptr! new-pair)
               (set-rear-ptr! new-pair))
              (else
               (set-cdr! rear-ptr new-pair)
               (set-cdr! (car new-pair) rear-ptr)
               (set-rear-ptr! new-pair)
               dispatch))))

    (define (delete-front-deque!)
      (cond ((empty-deque?)
             (error "DELETE! called with an empty deque"))
            (else
             (set-front-ptr! (cdr front-ptr))
             (set-cdr! (car front-ptr) '())
             dispatch)))

    (define (delete-rear-deque!)
      (cond ((empty-deque?)
             (error "DELETE! called with an empty deque"))
            (else
             (set-rear-ptr! (cdar rear-ptr))
             (set-cdr! rear-ptr '())
             dispatch)))

  (define (print-queue)
    (define (print-end) (display ")") (newline))
    (display "(")
    (let print-next ((next front-ptr))
      (cond ((null? next) (print-end))
            ((null? (cdr next)) (display (caar next))
                                 (print-end))
            (else (display (caar next))
                  (display " ")
                  (print-next (cdr next))))))

    (define (dispatch m)
      (cond ((eq? m 'set-front-ptr!) set-front-ptr!)
            ((eq? m 'set-rear-ptr!) set-rear-ptr!)
            ((eq? m 'empty-deque?) empty-deque?)
            ((eq? m 'front-deque) front-deque)
            ((eq? m 'insert-front-deque!) insert-front-deque!)
            ((eq? m 'insert-rear-deque!) insert-rear-deque!)
            ((eq? m 'delete-front-deque!) delete-front-deque!)
            ((eq? m 'delete-rear-deque!) delete-rear-deque!)
            ((eq? m 'print-deque) print-queue)
            (else (error "Method not found!"))))
    dispatch))

(define d (make-deque))

((d 'insert-front-deque!) 1)
((d 'insert-rear-deque!) 7)
((d 'insert-rear-deque!) 10)
((d 'insert-front-deque!) 0)
((d 'delete-front-deque!))
((d 'print-deque))
