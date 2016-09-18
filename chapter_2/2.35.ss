
;; Redefine count-leaves from section 2.2.2 as an accumulation:

;; (define (count-leaves t)
;;   (accumulate <??> <??> (map <??> <??>)))

;; copied from the book
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

; enumerate-tree from book
(define (enumerate-tree tree)
   (cond ((null? tree) tree)
         ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))

;; count-leaves from 2.2.2
(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) x)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

(define (count-leaves t)
  (accumulate + 0
              (map (lambda (x) 1)
                   (enumerate-tree t))))

(count-leaves '(1 (1 3 (4 5)))) ;; 5
