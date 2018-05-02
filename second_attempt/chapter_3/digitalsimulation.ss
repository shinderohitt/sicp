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
            ((eq? m 'empty?) (empty-queue?))
            (else (error "ERROR - UNKNOWN OP"))))
    dispatch))

(define (insert-queue! queue item)
  ((queue 'insert) item))
(define (delete-queue! queue)
  (queue 'delete))
(define (front-queue queue)
  (queue 'front))
(define (empty-queue? queue)
  (queue 'empty?))



(define (half-adder a b s c)
  (let ((d (make-wire)) (e (make-wire)))
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e s)
    'ok))

(define (inverter input output)
  (define (invert-input)
    (let ((new-value (logical-not (get-signal input))))
      (after-delay inverter-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! input invert-input)
  'ok)
(define (logical-not s)
  (cond ((= s 0) 1)
        ((= s 1) 0)
        (else (error "Invalid signal" s))))

(define (and-gate a1 a2 output)
  (define (logical-and in1 in2)
    (cond
     ;; First two conditions check if values are proper
     ;; ie, they both have to be either 0 or 1
     ((not (or (= in1 0) (= in1 1)))
      (error "Invalid input 1 value"))
     ((not (or (= in1 0) (= in1 1)))
      (error "Invalid input 1 value"))
     ((and (= in2 1)
           (= in1 1)) 1)
     (else 0)))
  (define (and-action-procedure)
    (let ((new-value
           (logical-and (get-signal a1) (get-signal a2))))
      (after-delay and-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! a1 and-action-procedure)
  (add-action! a2 and-action-procedure)
  'ok)


(define (or-gate a1 a2 output)
  (define (logical-or in1 in2)
    (cond
     ;; First two conditions check if values are proper
     ;; ie, they both have to be either 0 or 1
     ((not (or (= in1 0) (= in1 1)))
      (error "Invalid input 1 value"))
     ((not (or (= in1 0) (= in1 1)))
      (error "Invalid input 1 value"))
     ((= in1 1) 1)
     ((= in2 1) 1)
     (else 0)))
  (define (or-action-procedure)
    (let ((new-value
           (logical-or (get-signal a1) (get-signal a2))))
      (after-delay or-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure)
  'ok)

(define (call-each procedures)
  (if (null? procedures)
      'done
      (begin
        ((car procedures))
        (call-each (cdr procedures)))))

(define (make-wire)
  (let ((signal-value 0) (action-procedures '()))
    (define (set-my-signal! new-value)
      (if (not (= signal-value new-value))
          (begin (set! signal-value new-value)
                 (call-each action-procedures))
          'done))
    (define (accept-action-procedure! proc)
      (set! action-procedures (cons proc action-procedures))
      (proc))
    (define (dispatch m)
      (cond ((eq? m 'get-signal) signal-value)
            ((eq? m 'set-signal!) set-my-signal!)
            ((eq? m 'add-action!) accept-action-procedure!)
            (else (error "Unknown operation -- WIRE" m))))
    dispatch))

(define (get-signal wire)
  (wire 'get-signal))
(define (set-signal! wire new-value)
  ((wire 'set-signal!) new-value))
(define (add-action! wire action-procedure)
  ((wire 'add-action!) action-procedure))

(define (after-delay delay action)
  (add-to-agenda! (+ delay (current-time the-agenda))
                  action
                  the-agenda))

(define (propagate)
  (if (empty-agenda? the-agenda)
      'done
      (let ((first-item (first-agenda-item the-agenda)))
        (first-item)
        (remove-first-agenda-item! the-agenda)
        (propagate))))

(define (make-time-segment time queue)
  (cons time queue))
(define (segment-time s) (car s))
(define (segment-queue s) (cdr s))

(define (make-agenda) (list 0))
(define (current-time agenda) (car agenda))
(define (set-current-time! agenda time)
  (set-car! agenda time))
(define (segments agenda) (cdr agenda))
(define (set-segments! agenda segments)
  (set-cdr! agenda segments))
(define (first-segment agenda) (car (segments agenda)))
(define (rest-segments agenda) (cdr (segments agenda)))

(define (empty-agenda? agenda)
  (null? (segments agenda)))

(define (add-to-agenda! time action agenda)
  (define (belongs-before? segments)
    (or (null? segments)
        (< time (segment-time (car segments)))))
  (define (make-new-time-segment time action)
    (let ((q (make-queue)))
      (insert-queue! q action)
      (make-time-segment time q)))
  (define (add-to-segments! segments)
    (if (= (segment-time (car segments)) time)
        (insert-queue! (segment-queue (car segments))
                       action)
        (let ((rest (cdr segments)))
          (if (belongs-before? rest)
              (set-cdr!
               segments
               (cons (make-new-time-segment time action)
                     (cdr segments)))
              (add-to-segments! rest)))))
  (let ((segments (segments agenda)))
    (if (belongs-before? segments)
        (set-segments!
         agenda
         (cons (make-new-time-segment time action)
               segments))
        (add-to-segments! segments))))

(define (remove-first-agenda-item! agenda)
  (let ((q (segment-queue (first-segment agenda))))
    (delete-queue! q)
    (if (empty-queue? q)
        (set-segments! agenda (rest-segments agenda)))))

(define (first-agenda-item agenda)
  (if (empty-agenda? agenda)
      (error "Agenda is empty -- FIRST-AGENDA-ITEM")
      (let ((first-seg (first-segment agenda)))
        (set-current-time! agenda (segment-time first-seg))
        (front-queue (segment-queue first-seg)))))

(define (probe name wire)
  (add-action! wire
               (lambda ()
                 (newline)
                 (display name)
                 (display " ")
                 (display (current-time the-agenda))
                 (display "  New-value = ")
                 (display (get-signal wire)))))

(define the-agenda (make-agenda))
(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)

(define input-1 (make-wire))
(define input-2 (make-wire))
(define sum (make-wire))
(define carry (make-wire))
(probe 'sum sum)
(probe 'carry carry)

(half-adder input-1 input-2 sum carry)

(define (print-segment agenda)
  (display "Current Time = ")
  (display (current-time agenda))
  (display "\n")
  (define (iter-print-segs segments)
    (cond ((null? segments) (display "\n") (display "Done"))
          (else
           (let ((first (car segments))
                 (rest (cdr segments)))
             (display "  time = ")
             (display (car first))
             (display "\n")
             ((cdr first) 'print)
             (display "\n")
             (iter-print-segs rest)))))
  (iter-print-segs (segments agenda)))
;;(set-signal! input-1 1)
(print-segment the-agenda)

;; (define (x-first)
;;   (pp (first-agenda-item the-agenda))
;;   ((first-agenda-item the-agenda))
;;   (remove-first-agenda-item! the-agenda))

;; (x-first)
;; (propagate)
