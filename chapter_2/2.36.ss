;; The procedure accumulate-n is similar to accumulate except that
;; it takes as its third argument a sequence of sequences, which are all
;; assumed to have the same number of elements. It applies the designated
;; accumulation procedure to combine all the first elements of the sequences,
;; all the second elements of the sequences, and so on, and returns
;; a sequence of the results.

;; For instance, if s is a sequence containing four sequences,
;; ((1 2 3) (4 5 6) (7 8 9) (10 11 12)), then
;; the value of (accumulate-n + 0 s) should be the sequence (22 26 30).

;; Fill in the missing expressions in the following definition of accumulate-n:

;; (define (accumulate-n op init seqs)
;;   (if (null? (car seqs))
;;       nil
;;       (cons (accumulate op init <??>)
;;             (accumulate-n op init <??>))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

;; This accepts a list of lists, and returns a list of
;; first elements of each member list
(define (firsts l)
  (if (null? l) l
      (cons (caar l)
            (firsts (cdr l)))))

;; This accepts a list of lists, and returns
;; a list of lists, with all their first elments removed
(define (cdr-n l)
  (if (null? l) l
      (cons (cdr (car l))
            (cdr-n (cdr l)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (firsts seqs))
            (accumulate-n op init (cdr-n seqs)))))

;; I guess it was like having not paid attention to what I read
;; in the section before. Below is a better way to do it.
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

(accumulate-n + 0 '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))
;; (22 26 30)
