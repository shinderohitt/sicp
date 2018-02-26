;; ' is converted to (quote x)
;; where x is the first complete expression after '
(car ''abracadabra)
;; is first converted to
(car '(quote abracadabra))
;; and then to
(car (quote (quote abracadabra)))
