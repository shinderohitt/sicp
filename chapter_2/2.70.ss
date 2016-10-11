
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

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))


 (define (element-of-set? x set)
   (cond ((null? set) false)
         ((equal? x (car set)) true)
         (else (element-of-set? x (cdr set)))))

 (define (encode-symbol smb tree)
   (define (branch-correct? branch)
     (if (leaf? branch)
         (equal? smb (symbol-leaf branch))
         (element-of-set? smb (symbols branch))))

   (let ((lb (left-branch tree))
         (rb (right-branch tree)))
     (cond ((branch-correct? lb)
            (if (leaf? lb) '(0) (cons 0 (encode-symbol smb lb))))
           ((branch-correct? rb)
            (if (leaf? rb) '(1) (cons 1 (encode-symbol smb rb))))
           (else (error "bad symbol -- ENCODE-SYMBOL" bit)))))

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

(define (successive-merge pairs)
  (if (<= (length pairs) 1)
      (car pairs)
      (let ((first (car pairs))
            (second (cadr pairs))
            (remain (cddr pairs)))
        (successive-merge (adjoin-set (make-code-tree first second) remain)))))



(define lyrics
  '((na 16) (yip 9) (sha 3) (get 2) (a 2) (job 2) (boom 1) (wah 1)))

(define song-tree (generate-huffman-tree lyrics))


(define song-lyrics
  '(get a job sha na na na na na na na na get a job sha na na na na na na
        na na wah yip yip yip yip yip yip yip yip yip sha boom))

(define song-message (encode song-lyrics song-tree))

(length song-message) ;; 84
;; so we need 84 bits to record the songs above with variable length encoding

;; with fixed bit encoding, we will need [log 8] = 3 bits for each word.
;; hense,
(* (length song-lyrics) 3) ;; 108
;; 108 bits.
