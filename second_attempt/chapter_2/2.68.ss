;; Exercise 2.68.  The encode procedure takes as arguments a message and
;; a tree and produces the list of bits that gives the encoded message.

;; (define (encode message tree)
;;   (if (null? message)
;;       '()
;;       (append (encode-symbol (car message) tree)
;;               (encode (cdr message) tree))))

;; Encode-symbol is a procedure, which you must write, that returns the
;; list of bits that encodes a given symbol according to a given
;; tree. You should design encode-symbol so that it signals an error if
;; the symbol is not in the tree at all. Test your procedure by encoding
;; the result you obtained in exercise 2.67 with the sample tree and
;; seeing whether it is the same as the original sample message.

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

(define (encode-symbol sym tree)
  (define (helper msg sym tree)
    (if (and (leaf? tree)
             (eq? (symbol-leaf tree) sym))
        msg
        (if (leaf? tree)
            (error "not matching" sym)
            (let* ((left-tree (left-branch tree))
                   (right-tree (right-branch tree))
                   (left-symbs (symbols left-tree))
                   (right-symbs (symbols right-tree)))
              (if ;; (begin
               ;;   (display "left symbols: ")
               ;;   (display left-symbs)
               ;;   (display ", ")
               ;;   (display "right symbols: ")
               ;;   (display right-symbs)
               ;;   (display "\n")
               (memq sym left-symbs)
               (helper (append msg '(0)) sym left-tree)
               (helper (append msg '(1)) sym right-tree))))))
  (helper '() sym tree))

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

;; samples from 2.67
(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))
(encode '(A D A B B C A) sample-tree)
;; (0 1 1 0 0 1 0 1 0 1 1 1 0)
