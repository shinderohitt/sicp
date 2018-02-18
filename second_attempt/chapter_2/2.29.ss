;; Exercise 2.29.  A binary mobile consists of two branches, a left
;; branch and a right branch. Each branch is a rod of a certain length,
;; from which hangs either a weight or another binary mobile. We can
;; represent a binary mobile using compound data by constructing it from
;; two branches (for example, using list):

(define (make-mobile left right)
  (list left right))

;; A branch is constructed from a length (which must be a number)
;; together with a structure, which may be either a number (representing
;; a simple weight) or another mobile:

(define (make-branch length structure)
  (list length structure))

;; a.  Write the corresponding selectors left-branch and right-branch,
;; which return the branches of a mobile, and branch-length and
;; branch-structure, which return the components of a branch.

;; b.  Using your selectors, define a procedure total-weight that returns
;; the total weight of a mobile.

;; c.  A mobile is said to be balanced if the torque applied by its
;; top-left branch is equal to that applied by its top-right branch (that
;; is, if the length of the left rod multiplied by the weight hanging
;; from that rod is equal to the corresponding product for the right
;; side) and if each of the submobiles hanging off its branches is
;; balanced. Design a predicate that tests whether a binary mobile is
;; balanced.

;; d.  Suppose we change the representation of mobiles so that the
;; constructors are

(define (make-mobile left right)
  (cons left right))
(define (make-branch length structure)
  (cons length structure))

;; How much do you need to change your programs to convert to the new
;; representation?

;; a.
(define (left-branch mobile) (car mobile))
(define (right-branch mobile) (cdr mobile))
(define (branch-length branch) (car branch))
(define (branch-structure branch) (cdr branch))


;; b.
;; pardon for the unreadability of the snippet below
(define (total-weight mobile)
  (define (branches-weight branch)
    (cond ((null? branch) 0)
          ((number? (branch-structure branch)) (branch-structure branch))
          (else (+ (branches-weight (right-branch (branch-structure branch)))
                   (branches-weight (left-branch (branch-structure branch)))))))
  (+ (branches-weight (left-branch mobile))
     (branches-weight (right-branch mobile))))

(define level-1-mobile (make-mobile (make-branch 2 1)
                                    (make-branch 1 2)))
(define level-2-mobile (make-mobile (make-branch 3 level-1-mobile)
                                    (make-branch 9 1)))
(define level-3-mobile (make-mobile (make-branch 4 level-2-mobile)
                                    (make-branch 8 2)))

;; (total-weight level-1-mobile)
;; (total-weight level-2-mobile)
;; (total-weight level-3-mobile)

;; c.

;; TODO finish the solution below
;; (define (branch-has-leaves? branch)
;;   (let* ((r (branch-structure branch))
;;          (left (left-branch r))
;;          (right (right-branch r)))
;;     (and (number? (branch-structure r))
;;          (number? (branch-structure r)))))

;; (define (equal-torque? branch)
;;   (let* ((r (branch-structure branch))
;;          (left (left-branch r))
;;          (right (right-branch r)))
;;     (= (* (branch-length left)
;;           (branch-structure left))
;;        (* (branch-length right)
;;           (branch-structure right)))))

;; (define (is-branch? t)
;;   (number? (branch-length t)))

;; (define (balanced? t)
;;   (cond ((null? t) #t)
;;         ((and (pair? t)
;;               (branch-has-leaves? t))
;;          (equal-torque? t))
;;         ((is-branch? t) (balanced? t))
;;         (else (and (balanced? (right-branch t))
;;                    (balanced? (left-branch t))))))


;; (balanced? level-1-mobile)
;; (balanced? level-2-mobile)
;; (balanced? level-3-mobile)
