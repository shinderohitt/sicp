;; Exercise 2.55.  Eva Lu Ator types to the interpreter the expression

;; (car ''abracadabra)

;; To her surprise, the interpreter prints back quote. Explain.



;; Scheme Interpreter replaces the expression that occurs right after
;; ' (the single quote), and wraps it within (quote ... ) where it
;; is considered as stream of symbols, and is not evaluated as a normal
;; S-expression.

;; Hense,

;; (car ''abracadabra)

;; Becomes

;; (car '(quote abracadabra))

;; Now that there is one more quote, the expression after it - (quote abracadabra)
;; is again passed to (quote ... ). Note that, this time it is data, and not a pointer
;; to the definition quote itself. Now it will be -

;; (car (quote (quote abracadabra)))

;; Which is like, passing [ (quote abracadabra) ] -- a list of two symbols
;; "quote", and "abracadabra" to car. Which, obviously, will return the first symbol

;; abracadabra.
