;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 4.14.  Eva Lu Ator and Louis Reasoner are each experimenting ;;
;; with the metacircular evaluator. Eva types in the definition of map,  ;;
;; and runs some test programs that use it. They work fine. Louis, in    ;;
;; contrast, has installed the system version of map as a primitive for  ;;
;; the metacircular evaluator. When he tries it, things go terribly      ;;
;; wrong. Explain why Louis's map fails even though Eva's works.         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Both host, and guest languages represent underlying procedure's structures
;; differently. When we set map as a primitive, its arguments are still
;; evaluated by implemented eval. This in turn returns evaluated versions
;; of the passed in arguments.

;; For eg,
;; (map square (1 2 3))
;; expression would be evaluated to something to the effect --
;; (map ('application square) (1 2 3))

;; And the underlying scheme does not know how to get along with
;; something like -- ('application square) .. If square is a primitive
;;                   ('procedure squre <params> <body> <env>) otherwise

;; since the primitive map expects a reference to
;; a procedure object instead of a list.
