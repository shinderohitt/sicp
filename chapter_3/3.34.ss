;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 3.34.  Louis Reasoner wants to build a squarer, a constraint ;;
;; device with two terminals such that the value of connector b on the   ;;
;; second terminal will always be the square of the value a on the first ;;
;; terminal. He proposes the following simple device made from a         ;;
;; multiplier:                                                           ;;
;;                                                                       ;;
;; (define (squarer a b)                                                 ;;
;;   (multiplier a a b))                                                 ;;
;;                                                                       ;;
;; There is a serious flaw in this idea. Explain.                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


When b is set, we should expect square root through connector a.
But for connector a to return any value,
we will need "another" a [from -- (multiplier a a b)] to be set.
Which cannot happen. Hense, no signal ever.
