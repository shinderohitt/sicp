;; If we computer make-cycle on a given list,
;; we are basically linking the cdr pointer of the last
;; pair in the list to the first pair of in the same list.

;; This creates a loop, a circular list whose end points
;; to its start. Leaving no cdr pointing to empty/null.

;; Our last-pair relies on a pair in the list whose cdr
;; points to nothing to figure out the last pair in the list.

;; Since make-cycle removes that null pointer from the list,
;; and since the list is now a circular list,
;; last-pair would run recursively wihout ever halting.
