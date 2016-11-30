;; Exercise 3.16.  Ben Bitdiddle decides to write a procedure to count
;; the number of pairs in any list structure. ``It's easy,'' he
;; reasons. ``The number of pairs in any structure is the number in the
;; car plus the number in the cdr plus one more to count the current
;; pair.'' So Ben writes the following procedure:

(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

;; Show that this procedure is not correct. In particular, draw
;; box-and-pointer diagrams representing list structures made up of
;; exactly three pairs for which Ben's procedure would return 3; return
;; 4; return 7; never return at all.

(count-pairs '(b b b)) ;; 3

(define z1 '(a))
(define z2 '(d))
(define z3 (cons z1 z2))

(set-car! z1 z2)
(count-pairs z3) ;; 4

(define z1 '(a b))
(define z2 '(d x))
(define z3 (cons z1 z2))

(set-car! z1 z2)
(count-pairs z3) ;; 7

(define z1 '(a b))
(set-cdr! z1 z1)
(count-pairs z1) ;; never return
