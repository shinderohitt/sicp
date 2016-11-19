;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 3.3.  Modify the make-account procedure so that it creates ;;
;; password-protected accounts. That is, make-account should take a    ;;
;; symbol as an additional argument, as in                             ;;
;;                                                                     ;;
;; (define acc (make-account 100 'secret-password))                    ;;
;;                                                                     ;;
;; The resulting account object should process a request only if it is ;;
;; accompanied by the password with which the account was created, and ;;
;; should otherwise return a complaint:                                ;;
;;                                                                     ;;
;; ((acc 'secret-password 'withdraw) 40)                               ;;
;; 60                                                                  ;;
;;                                                                     ;;
;; ((acc 'some-other-password 'deposit) 50)                            ;;
;; "Incorrect password"                                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(define (make-account balance password)
  (let ((failures 0))
    (define (withdraw amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient funds"))
    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)

    (define (call-the-cops x) "Call the cops")
    (define (incorrect-password x) "Incorrect Password")
    (define (handle-incorrect-password)
      (begin
        (set! failures (+ failures 1))
        (if (>= failures 7)
            call-the-cops
            incorrect-password)))

    (define (dispatch secret m)
      (cond ((not (eq? password secret))
             (handle-incorrect-password))
            ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            (else (error "Unknown request -- MAKE-ACCOUNT"
                         m))))
    dispatch))



(define acc (make-account 100 'secret-password))

((acc 'secret-password 'withdraw) 40)
;; 60

((acc 'some-other-password 'deposit) 50)
;; "Incorrect password"
