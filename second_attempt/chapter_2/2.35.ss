(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

;; from 2.2.2
;; (define (count-leaves x)
;;   (cond ((null? x) 0)
;;         ((not (pair? x)) 1)
;;         (else (+ (count-leaves (car x))
;;                  (count-leaves (cdr x))))))

(define sample '((1 2 3 (5 (10))) ((1) (3 4 (1)))))

(define (enumerate-tree t)
  (cond ((null? t) '())
        ((not (pair? t)) (list t))
        (else (append (enumerate-tree (car t))
                      (enumerate-tree (cdr t))))))

(define (count-leaves t)
  (accumulate
   +
   0
   (map (lambda (x) 1) (enumerate-tree sample))))

(count-leaves sample) ;; 9
