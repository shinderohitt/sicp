;; Exercise 2.76.  As a large system with generic operations evolves,
;; new types of data objects or new operations may be needed.

;; For each of the three strategies -- generic operations with explicit dispatch,
;; data-directed style, and message-passing-style --
;; describe the changes that must be made to a system in order to add new types
;; or new operations.

* Generic Operations:
We will need to change every single existing procedure that handles
the new type.
We will need to make sure that there are no introduction of name conflicts.

* Data-directed style:
We will need to add, and install a new prodedure to the table. This will
not affect the rest of the system.

* Message-Passing style:
We will only need to change the object of the type where we will add
the new procedure.

;; Which organization would be most appropriate for a system in which
;; new types must often be added?
;; Which would be most appropriate for a system in which new operations
;; must often be added?

;; In both scenarios above, the change to a system is minimal, as it only
;; affects the new type/operation being added. But having operations
;; internal to a type appears to be a better organization of the system.
