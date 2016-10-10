;; Exercise 2.69.  The following procedure takes as its argument a list of
;; symbol-frequency pairs (where no symbol appears in more than one pair)
;; and generates a Huffman encoding tree according to the Huffman algorithm.

;; (define (generate-huffman-tree pairs)
;;   (successive-merge (make-leaf-set pairs)))

;; Make-leaf-set is the procedure given above that transforms the list of pairs
;; into an ordered set of leaves. successive-merge is the procedure you must write,
;; using make-code-tree to successively merge the smallest-weight elements of the set
;; until there is only one element left, which is the desired Huffman tree.

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

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)    ; symbol
                               (cadr pair))  ; frequency
                    (make-leaf-set (cdr pairs))))))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

;; my solution -
;; better solution below (modified to be correct)
;; from http://community.schemewiki.org/?sicp-ex-2.69
;; (define (successive-merge pairs)
;;   (define (make-tree tree ipairs)
;;     (if (<= (length ipairs) 1)
;;         tree
;;         (let ((first (car ipairs))
;;               (second (cadr ipairs))
;;               (remaining (cddr ipairs)))
;;           (make-tree (make-code-tree first second)
;;                      (adjoin-set (make-code-tree first second)
;;                                  remaining)))))
;;   (make-tree '() pairs))

(define (successive-merge pairs)
  (if (<= (length pairs) 1)
      (car pairs)
      (let ((first (car pairs))
            (second (cadr pairs))
            (remain (cddr pairs)))
        (successive-merge (adjoin-set (make-code-tree first second) remain)))))

(define sample-pairs '((A 4) (B 2) (C 1) (D 1)))
(generate-huffman-tree sample-pairs)
;; ((leaf a 4) ((leaf b 2) ((leaf d 1) (leaf c 1) (d c) 2) (b d c) 4) (a b d c) 8)
