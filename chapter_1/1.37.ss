
(define (cont-free n d k)
  (define (helper k-pos)
    (if (> k-pos k)
        (/ (n k-pos) (d k-pos))
        (/ (n k-pos)
           (+ (d k-pos)
              (helper (+ k-pos 1))))))
  (helper 1))

(cont-free (lambda (i) 1.0)
           (lambda (i) 1.0)
           10) ;; .6180555555555556

;; so k = 10
;; gives us the value of 1/ø,
;; accurate to 4 decimal places

;; an iterative version

(define (cont-free n d k)
  (define (helper k-pos result)
    (if (= k-pos 0)
        result
        (helper (- k-pos 1)
                (/ (n k-pos) (+ (d k-pos) result)))))
  (helper k (/ (n k) (d k))))

(cont-free (lambda (i) 1.0)
           (lambda (i) 1.0)
           10) ;; .6180555555555556
