;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 3.47.  A semaphore (of size n) is a generalization of a      ;;
;; mutex. Like a mutex, a semaphore supports acquire and release         ;;
;; operations, but it is more general in that up to n processes can      ;;
;; acquire it concurrently. Additional processes that attempt to acquire ;;
;; the semaphore must wait for release operations. Give implementations  ;;
;; of semaphores                                                         ;;
;;                                                                       ;;
;; a. in terms of mutexes                                                ;;
;;                                                                       ;;
;; b. in terms of atomic test-and-set! operations.                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; snippets from the book
(define (make-mutex)
  (let ((cell (list false)))
    (define (the-mutex m)
      (cond ((eq? m 'acquire)
             (if (test-and-set! cell)
                 (the-mutex 'acquire))) ; retry
            ((eq? m 'release) (clear! cell))))
    the-mutex))

(define (clear! cell)
  (set-car! cell false))

(define (test-and-set! cell)
  (if (car cell)
      true
      (begin (set-car! cell true)
             false)))

;; solution
;; a
(define (make-semaphore n)
  (let ((resources n)
        (mutex (make-mutex)))
    (define (the-semaphore m)
      (cond ((eq? m 'acquire)
             (begin (mutex 'acquire)
                    (if (> resources 0)
                        ((resources (- resources 1)))
                        (mutex 'release))
                    (the-semaphore 'acquire)))
            ((eq? m 'release)
             (begin
               (mutex 'acquire)
               (resources (+ resources 1))
               (mutex 'release)))))
    the-semaphore))

;; b
(define (make-semaphore n)
  (let ((resources n)
        (key #f))
    (define (the-semaphore m)
      (cond ((eq? m 'acquire)
             (begin (test-and-set! key)
                    (if (> resources 0)
                        ((resources (- resources 1)))
                        (clear! key))
                    (the-semaphore 'acquire)))
            ((eq? m 'release)
             (begin
               (test-and-set! key)
               (resources (+ resources 1))
               (release! key)))))
    the-semaphore))
