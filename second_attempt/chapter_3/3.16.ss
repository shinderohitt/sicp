(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

(define x '(a))
(define y '(c))
(define z '(e))
(count-pairs '((3) (2) ((1))))

;; 1: '(a b c)
;; 2: ('x 'y '(1))
;; 3: ((3) (2) ((1)))
;; 4:
(define z (list 1 2))
(set-cdr! (cdr z) z)
;; (count-pairs z) --> ;Aborting!: maximum recursion depth exceeded
