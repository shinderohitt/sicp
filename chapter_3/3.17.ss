;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 3.17.  Devise a correct version of the count-pairs procedure ;;
;; of exercise 3.16 that returns the number of distinct pairs in any     ;;
;; structure. (Hint: Traverse the structure, maintaining an auxiliary    ;;
;; data structure that is used to keep track of which pairs have already ;;
;; been counted.)                                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(define (count-pairs x)
  (let ((seen '()))
      (define (count x)
        (if (or (memq x seen)
                (not (pair? x)))
            0
            (begin
              (set! seen (cons x seen))
              (+ (count (car x))
                 (count (cdr x))
                 1))))
    (count x)))
