;; 2.46

(define (make-vect x-cor y-cor) (cons x-cor y-cor))
(define (x-cor vect) (car vect)) ;; can also be : (define x-cor car)
(define (y-cor vect) (cdr vect)) ;; similarly   : (define y-cor  cdr)

;; (define foo (make-vect 0.5 0.6))
;; (define bar (make-vect 0.1 0.2))

;; (x-cor foo) ;; .5
;; (y-cor foo) ;; .6


(define (add-vect a b)
  (make-vect
   (+ (x-cor a) (x-cor b))
   (+ (y-cor a) (y-cor b))))

(define (sub-vect a b)
  (make-vect
   (- (x-cor a) (x-cor b))
   (- (y-cor a) (y-cor b))))

(define (scale-vect factor vector)
  (make-vect (* factor (x-cor vector))
             (* factor (y-cor vector))))


;; (add-vect foo bar) ;; (.6, .8)
;; (sub-vect foo bar) ;; (.4, .4)
;; (scale-vect 2 bar) ;; (.2, .4)
