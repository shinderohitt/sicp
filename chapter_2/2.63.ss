
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))



(define tree1
  '(7 (3 (1 () ()) (5 () ())) (9 () (11 () ()))))

(tree->list-1 tree1) ;; (1 3 5 7 9 11)
(tree->list-2 tree1) ;; (1 3 5 7 9 11)

;; Though both trees produces the same output,
;; the way they traverse the tree is different.

tree->list-1 traverses the tree as left->center->right
tree->list-2 traverses the tree as right->center->left

;; yet they produce the same output
;; It is because how we cons together the output from
;; consecutive calls to the procedures is totally different
