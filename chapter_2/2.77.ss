;; Exercise 2.77.  Louis Reasoner tries to evaluate the expression
;; (magnitude z) where z is the object shown in figure 2.24. To his
;; surprise, instead of the answer 5 he gets an error message from
;; apply-generic, saying there is no method for the operation magnitude
;; on the types (complex). He shows this interaction to Alyssa P. Hacker,
;; who says ``The problem is that the complex-number selectors were never
;; defined for complex numbers, just for polar and rectangular
;; numbers. All you have to do to make this work is add the following to
;; the complex package:''

;; (put 'real-part '(complex) real-part)
;; (put 'imag-part '(complex) imag-part)
;; (put 'magnitude '(complex) magnitude)
;; (put 'angle '(complex) angle)

;; Describe in detail why this works. As an example, trace through all
;; the procedures called in evaluating the expression (magnitude z) where
;; z is the object shown in figure 2.24. In particular, how many times is
;; apply-generic invoked? What procedure is dispatched to in each case?







;; Initially, the complex package did not have any procedure named magnitude
;; exposed to be called, hense the error.

;; After adding the procedures in the install package, it is exposed outside
;; and we can use it.

;; There is a two level of abstraction

;; COMPLEX => RECTANGULAR => CONTENT


;; Hense, apply-generic is invoked twice to get to the procedure which
;; actually handles retrieving the magnitude part of the number.


;; The sequence in which the procedures would be called can be illustrated
;; as below (assuming the complex number is represented as polar):

;; (magnitude z) ;; top level
;; (apply-generic 'magnitude z) ;; (first level)
;; (magnitude z) ;; second leve
;; (apply-generic 'magnitude z) ;; (second level)
;; (magnitude z) ;; third level
;; (car z)
