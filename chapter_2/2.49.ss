#lang scheme
(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

(define (make-vect x y)
  (cons x y))

(define (xcor-vect v)
  (car v))

(define (ycor-vect v)
  (cdr v))

(define (add-vect v1 v2)
  (make-vect (+ (xcor-vect v1)
                (xcor-vect v2))
             (+ (ycor-vect v1)
                (ycor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect (- (xcor-vect v1)
                (xcor-vect v2))
             (- (ycor-vect v1)
                (ycor-vect v2))))

(define (scale-vect s v)
  (make-vect (* s (xcor-vect v))
             (* s (ycor-vect v))))


(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame f)
  (car f))

(define (edge1-frame f)
  (cadr f))

(define (edge2-frame f)
  (caddr f))

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

(define make-segment cons)
(define start-segment car)
(define end-segment cdr)

;; a
(define outline-segments
 (list
  (make-segment
   (make-vect 0.0 0.0)
   (make-vect 0.0 0.9))
  (make-segment
   (make-vect 0.0 0.0)
   (make-vect 0.9 0.0))
  (make-segment
   (make-vect 0.9 0.0)
   (make-vect 0.9 0.9))
  (make-segment
   (make-vect 0.0 0.9)
   (make-vect 0.9 0.9))))
(define outline (segments->painter outline-segments))
(paint outline)

;; b
(define x-segments
 (list
  (make-segment
   (make-vect 0.0 0.0)
   (make-vect 0.9 0.9))
  (make-segment
   (make-vect 0.9 0.0)
   (make-vect 0.0 0.9))))
(define x (segments->painter x-segments))
(paint x)

;; c
(define diamond-segments
 (list
  (make-segment
   (make-vect 0.0 0.5)
   (make-vect 0.5 0.99))
  (make-segment
   (make-vect 0.5 0.99)
   (make-vect 0.99 0.5))
  (make-segment
   (make-vect 0.99 0.5)
   (make-vect 0.5 0.0))
  (make-segment
   (make-vect 0.5 0.0)
   (make-vect 0.0 0.5))))
(define diamond (segments->painter diamond-segments))
(paint diamond)