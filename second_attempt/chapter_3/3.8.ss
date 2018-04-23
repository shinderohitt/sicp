
;; One silly solution i can think of right now
;; Sleepy.
(define f
  (let ((inner -1))
    (lambda (x)
      (if (< inner 0)
          (begin
            (set! inner (if (= x 1) 0 0.5))
            inner)
          inner))))
