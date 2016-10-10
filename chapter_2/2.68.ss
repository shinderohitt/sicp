;; Exercise 2.68.  The encode procedure takes as arguments a message and
;; a tree and produces the list of bits that gives the encoded message.

;; (define (encode message tree)
;;   (if (null? message)
;;       '()
;;       (append (encode-symbol (car message) tree)
;;               (encode (cdr message) tree))))

;; Encode-symbol is a procedure, which you must write, that returns
;; the list of bits that encodes a given symbol according to a given tree.


(define (make-leaf symbol weight)
  (list 'leaf symbol weight))
(define (leaf? object)
  (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))

(define (right-branch tree) (cadr tree))
(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))
(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))
(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))


(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol letter tree)
  (let ((lb (left-branch tree))
        (rb (right-branch tree)))
    (cond ((null? tree) "ERROR")
          ((not (member letter (symbols tree)))
           "ERROR: letter not present")
          ((and (leaf? lb)
                (equal? (symbol-leaf lb) letter)) '(0))
          ((and (leaf? rb)
                (equal? (symbol-leaf rb) letter)) '(1))
          (else
           (if (leaf? lb)
               (cons 1 (encode-symbol letter rb))
               (cons 0 (encode-symbol letter lb)))))
          )))

(define encoded-message (encode '(a d a b b c a) sample-tree))


(equal? encoded-message sample-message) ;; t
