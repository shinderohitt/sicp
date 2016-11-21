;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 3.5.  Monte Carlo integration is a method of estimating       ;;
;; definite integrals by means of Monte Carlo simulation. Consider        ;;
;; computing the area of a region of space described by a predicate P(x,  ;;
;; y) that is true for points (x, y) in the region and false for points   ;;
;; not in the region. For example, the region contained within a circle   ;;
;; of radius 3 centered at (5, 7) is described by the predicate that      ;;
;; tests whether (x - 5)² + (y - 7)²< 32. To estimate the area of the     ;;
;; region described by such a predicate, begin by choosing a rectangle    ;;
;; that contains the region. For example, a rectangle with diagonally     ;;
;; opposite corners at (2, 4) and (8, 10) contains the circle above. The  ;;
;; desired integral is the area of that portion of the rectangle that     ;;
;; lies in the region. We can estimate the integral by picking, at        ;;
;; random, points (x,y) that lie in the rectangle, and testing P(x, y)    ;;
;; for each point to determine whether the point lies in the region. If   ;;
;; we try this with many points, then the fraction of points that fall in ;;
;; the region should give an estimate of the proportion of the rectangle  ;;
;; that lies in the region. Hence, multiplying this fraction by the area  ;;
;; of the entire rectangle should produce an estimate of the integral.    ;;
;;                                                                        ;;
;; Implement Monte Carlo integration as a procedure estimate-integral     ;;
;; that takes as arguments a predicate P, upper and lower bounds x1, x2,  ;;
;; y1, and y2 for the rectangle, and the number of trials to perform in   ;;
;; order to produce the estimate. Your procedure should use the same      ;;
;; monte-carlo procedure that was used above to estimate . Use your       ;;
;; estimate-integral to produce an estimate of by measuring the area of a ;;
;; unit circle.                                                           ;;
;;                                                                        ;;
;; You will find it useful to have a procedure that returns a number      ;;
;; chosen at random from a given range. The following random-in-range     ;;
;; procedure implements this in terms of the random procedure used in     ;;
;; section 1.2.6, which returns a nonnegative number less than its        ;;
;; input.8                                                                ;;
;;                                                                        ;;
;;                                                                        ;;
;; (define (random-in-range low high)                                     ;;
;;   (let ((range (- high low)))                                          ;;
;;     (+ low (random range))))                                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (rand-generator x-low x-high y-low y-high)
  (lambda ()
    (cons (random-in-range x-low x-high)
          (random-in-range y-low y-high))))

(define (within-region? origin radius test-point)
  (let ((origin-x (car origin))
        (origin-y (cadr origin))
        (x (car test-point))
        (y (cdr test-point))
        (radius-square (square radius)))
    (<= (+ (square (- x origin-x))
           (square (- y origin-y)))
        radius-square)))

(define (experiment-generator origin radius)
  (let ((origin-x (car origin))
        (origin-y (cadr origin)))
    (let ((x-low (- origin-x radius))
          (x-high (+ origin-x radius))
          (y-low (- origin-y radius))
          (y-high (+ origin-y radius)))
      (let ((rand (rand-generator x-low x-high y-low y-high)))
        (lambda ()
          (within-region? origin radius (rand)))))))

(define experiment (experiment-generator '(5.0 7.0) 3.0))


(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))


(/ (* 36 (exact->inexact (monte-carlo 1000 experiment)))
   9.0)

;; 3.176



;; I was supposed to write estimate-integral.
;; NOTE-TO-SELF: Read the problem carefully, don't jump right off into
;; solution.


;; NOTE: A *way* better solution (http://community.schemewiki.org/?sicp-ex-3.5)
(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))
(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (P x y)
  (< (+ (expt (- x 5) 2)
        (expt (- y 7) 2))
     (expt 3 2)))
(define (estimate-integral P x1 x2 y1 y2 trials)
  (define (experiment)
    (P (random-in-range x1 x2)
       (random-in-range y1 y2)))
  (monte-carlo trials experiment))
