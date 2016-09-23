;; Here are two possible constructors for frames:

;; (define (make-frame origin edge1 edge2)
;;   (list origin edge1 edge2))

;; (define (make-frame origin edge1 edge2)
;;   (cons origin (cons edge1 edge2)))

;; For each constructor supply the appropriate selectors
;; to produce an implementation for frames.


;; first constructor
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

;; selectors
(define (origin-frame frame)
  (car frame))
(define (edge1-frame frame)
  (car (cdr frame)))
(define (edge2-frame frame)
  (car (cddr frame)))

;; (define foo (make-frame 1 2 3))
;; (origin-frame foo) ;; 1
;; (edge1-frame foo)  ;; 2
;; (edge2-frame foo)  ;; 3


;; second constructor
(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

;; selectors for above
(define (origin-frame frame)
  (car frame))
(define (edge1-frame frame)
  (car (cdr frame)))
(define (edge2-frame frame)
  (cddr frame))


;; (define foo (make-frame 1 2 3))
;; (origin-frame foo) ;; 1
;; (edge1-frame foo)  ;; 2
;; (edge2-frame foo)  ;; 3
