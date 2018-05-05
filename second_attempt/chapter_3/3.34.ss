;; A constraint "adjusts" its operation based on its inputs.
;; A multiplier for instance, sets its output to the product
;; of its both inputs. If one of the inputs is missing,
;; and output and other input is available, then it sets the input
;; with missing value to a proper value (division).

;; Using multiplier to simulate squarer wouldn't work for this
;; very reason. If multiplier's output is available, input not,
;; then the input should be set to the square-root of its output connector.
