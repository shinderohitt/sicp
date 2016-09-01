
;; Solution to 2.29 (Binary Mobile)

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define left-branch car)
(define (right-branch x) (car (cdr x)))

(define branch-length car)
(define (branch-structure x) (car (cdr x)))

(define (total-weight mobile)
  (let ((leftb (branch-structure (left-branch mobile)))
        (rightb (branch-structure (right-branch mobile))))
    (cond ((and (list? leftb)
                (list? rightb))
           (+ (total-weight leftb)
              (total-weight rightb)))
          ((and (list? leftb)
                (not (list? rightb)))
           (+ (total-weight leftb) rightb))
          ((and (not (list? leftb))
                (list? rightb))
           (+ leftb (total-weight rightb)))
          (else (+ leftb rightb)))))


(define t1 '(( 12 3 ) ( 1 4)) )
(define t2 '((1 2) (1 ((2 2) (3 2)))) )
(define t3 '((1 2) (1 ((2 2) (1 ((1 2) (1 3)))))) )
(define t4 '((1 ((1 2) (1 3))) (1 ((2 2) (3 2)))) )

(total-weight t1) ;; 7
(total-weight t2) ;; 6
(total-weight t3) ;; 9
(total-weight t4) ;; 9

(define (is-balanced mobile)
  (let ((lefts (branch-structure (left-branch mobile)))
        (rights (branch-structure (right-branch mobile)))
        (leftl (branch-length (left-branch mobile)))
        (rightl (branch-length (right-branch mobile))))
    (cond ((and (list? lefts)
                (list? rights))
           (and (is-balanced (lefts))
                (is-balanced (rights))
                (= (* leftl (total-weight lefts))
                   (* rightl (total-weight rights)))))
          ((and (list? lefts)
                (not (list? rights)))
           (and (is-balanced (lefts))
                 (= (* leftl (total-weight lefts))
                    (* rightl rights))))
          ((and (not (list? lefts))
                (list? rights))
           (and (= (* rightl (total-weight rightl))
                   (* leftl lefts))
                (is-balanced (rights))))
          (else (= (* leftl lefts)
                   (* rightl rights))))))

;; following examples are taken from
;; http://www.billthelizard.com/2011/02/sicp-229-binary-mobiles.html
(define a (make-mobile (make-branch 2 3) (make-branch 2 3)))
(define b (make-mobile (make-branch 2 3) (make-branch 4 5)))

(is-balanced a) ; #t
(is-balanced b) ; #f


;; Suppose we change the representation of mobiles
;; so that the constructors are

;; (define (make-mobile left right)
;;   (cons left right))
;; (define (make-branch length structure)
;;   (cons length structure))

;; In the solution above, we will need to use pair? instead of list?
