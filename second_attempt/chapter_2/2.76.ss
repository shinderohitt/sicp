;; For the addition of new types, and new operations,
;; the changes required to each of the style

;; Generic operations with explicit dispatch
;; >> Each new type requires adding a new condition in each
;; of the generic operation.
;; >> Each new operation requires adding a new generic operation
;; with switch-like type handler for with each type in it

;; Data-Directed style
;; >> Each new type requires only the installation of a new package
;; >> Each new operation only requires adding the operation to individual
;; package, and putting them in the type->op table.

;; Message passing
;; Each new type is a separate object, with operations internal
;; to it. So,
;; >> A new type is a new object,
;; >> A new operation is changes to respective type-objects
