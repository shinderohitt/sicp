;; Fill in the missing expressions to complete the following
;; definitions of some basic list-manipulation operations as accumulations:

;; (define (map p sequence)
;;   (accumulate (lambda (x y) <??>) nil sequence))
;; (define (append seq1 seq2)
;;   (accumulate cons <??> <??>))
;; (define (length sequence)
;;   (accumulate <??> 0 sequence))


;; copied from the book
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))


(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) '() sequence))
(map square '(1 2 3)) ;; (1 4 9)


(define (append seq1 seq2)
  (accumulate cons seq2 seq1))
(append '(1 2 3) '(4 5)) ;; (1 2 3 4 5)


(define (length sequence)
  (accumulate (lambda (x y) (1+ y)) 0 sequence))
(length '(1 2 3 4 7)) ;; 5
