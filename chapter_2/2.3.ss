
;; 2.3 something like 2.3, for rectangles
;; also, write procedures to calculate perimeter and the area
;; of given rectangle

(define (make-point x y) (cons x y))
(define (x-point point) (car point))
(define (y-point point) (cdr point))

(define (start-segment seg) (car seg))
(define (end-segment seg) (cdr seg))

(define (make-segment point-x point-y)
  (cons point-x point-y))

(define (midpoint-segment line-seg)
  (make-point (/ (+ (x-point (start-segment line-seg))
                    (x-point (end-segment line-seg)))
                 2)
              (/ (+ (y-point (start-segment line-seg))
                    (y-point (end-segment line-seg)))
                 2)))

;; (define (make-rect a b c d)
;;   (cons (cons a b) (cons c d)))

(define (make-rect a b c d)
  (cons a (cons b (cons c (cons d '())))))

(define (rect-a rect)
  (car rect))

(define (rect-b rect)
  (car (cdr rect)))

(define (rect-c rect)
  (car (cdr (cdr rect))))

(define (rect-d rect)
  (car (cdr (cdr (cdr rect)))))

(define (rect-area rect)
  (* (abs (- (x-point (rect-a rect))
             (x-point (rect-b rect))))
     (abs (- (y-point (rect-b rect))
             (y-point (rect-c rect))))))

(define (rect-perimeter rect)
  (* 2 (+ (abs (- (x-point (rect-a rect))
                  (x-point (rect-b rect))))
          (abs (- (y-point (rect-b rect))
                  (y-point (rect-c rect)))))))

(define x (make-rect (make-point 10 26)
                     (make-point 45 26)
                     (make-point 45 10)
                     (make-point 10 10)))

(rect-area x) ;; 560
(rect-perimeter x) ;; 102


;; Reactangle is represented as a list of Points in example above
;; The representation of the rectangle *can* be changed into something else
;; (for instance, let's just say a pair of line-segments)

;; The question is, whether we can keep rect-area, and rect-perimeter
;; unchanged even after changing the underlying representation of the rectanlge

;; The answer is Yes. As long as, the methods rect-a, rect-b, .., rect-c
;; return the respective points of the rectangle.


;; The abstraction layers would look something like shown below.

;; +------------------------------------------+
;;         rect-area, rect-perimeter
;; +------------------------------------------+
;;          rect-a, rect-b, .., rect-c
;; +------------------------------------------+
;;                 make-rect
;; +------------------------------------------+
;;                 make-point



;; So when make-rect changes, changing rectangle representation,
;; we will need to change rect-a, .., rect-c which will manipulate
;; the new data object, BUT will return the same thing they did before.

;; Hense, there is no need to change both rect-area, rect-perimeter.
