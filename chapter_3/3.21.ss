;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 3.21.  Ben Bitdiddle decides to test the queue implementation ;;
;; described above. He types in the procedures to the Lisp interpreter    ;;
;; and proceeds to try them out:                                          ;;
;;                                                                        ;;
;; (define q1 (make-queue))                                               ;;
;; (insert-queue! q1 'a)                                                  ;;
;; ((a) a)                                                                ;;
;; (insert-queue! q1 'b)                                                  ;;
;; ((a b) b)                                                              ;;
;; (delete-queue! q1)                                                     ;;
;; ((b) b)                                                                ;;
;; (delete-queue! q1)                                                     ;;
;; (() b)                                                                 ;;
;;                                                                        ;;
;; ``It's all wrong!'' he complains. ``The interpreter's response shows   ;;
;; that the last item is inserted into the queue twice. And when I delete ;;
;; both items, the second b is still there, so the queue isn't empty,     ;;
;; even though it's supposed to be.'' Eva Lu Ator suggests that Ben has   ;;
;; misunderstood what is happening. ``It's not that the items are going   ;;
;; into the queue twice,'' she explains. ``It's just that the standard    ;;
;; Lisp printer doesn't know how to make sense of the queue               ;;
;; representation. If you want to see the queue printed correctly, you'll ;;
;; have to define your own print procedure for queues.'' Explain what Eva ;;
;; Lu is talking about. In particular, show why Ben's examples produce    ;;
;; the printed results that they do. Define a procedure print-queue that  ;;
;; takes a queue as input and prints the sequence of items in the queue.  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))
(define (set-front-ptr! queue item) (set-car! queue item))
(define (set-rear-ptr! queue item) (set-cdr! queue item))

(define (empty-queue? queue) (null? (front-ptr queue)))

(define (make-queue) (cons '() '()))

(define (front-queue queue)
  (if (empty-queue? queue)
      (error "FRONT called with an empty queue" queue)
      (car (front-ptr queue))))

(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue)
           (set-front-ptr! queue new-pair)
           (set-rear-ptr! queue new-pair)
           queue)
          (else
           (set-cdr! (rear-ptr queue) new-pair)
           (set-rear-ptr! queue new-pair)
           queue))))

(define (delete-queue! queue)
  (cond ((empty-queue? queue)
         (error "DELETE! called with an empty queue" queue))
        (else
         (set-front-ptr! queue (cdr (front-ptr queue)))
         queue)))


;; Queue is just a pair of pointers to the front and rear
;; of the list (which actually contains the content of the queue).

;; When Ben prints the queue, the interpreter is actually printing
;; this pair of pointers (front, rear)

;; In our case,
;; front points to the first element of the list.
;; > prints the whole list as the first part of the pair
;; rear points to the last element of the list
;; > prints the last element as the second part of the pair

;; Now when we delete the last element in the queue, we are only
;; moving the front pointer to its next neighbour, and not doing
;; anything about the rear pointer. Which keeps pointing to the
;; last element. So even when the queue is empty, we see the last
;; element.


(define (print-queue queue)
  (if (empty-queue? queue)
      (display "The Queue is empty!")
      (display (front-ptr queue))))

(define q1 (make-queue))

(print-queue (insert-queue! q1 'a)) ;; (a)
(print-queue (insert-queue! q1 'c)) ;; (a c)
(print-queue (delete-queue! q1))    ;; (c)
(print-queue (delete-queue! q1))    ;; The Queue is empty!
