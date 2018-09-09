;; .. adding this to analyze would do the trick

((let? exp) (analyze (let->combination exp)))

;; we use the asme let->combination from 4.6, except,
;; the returned lambda from it, is analyzed in turn.
