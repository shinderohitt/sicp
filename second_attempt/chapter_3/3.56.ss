(define S
  (cons-stream 1 (merge (scale-stream S 2)
                        (merge (scale-stream 3)
                               (scale-stream 5)))))
