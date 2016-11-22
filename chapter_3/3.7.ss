;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 3.7.  Consider the bank account objects created by            ;;
;; make-account, with the password modification described in exercise     ;;
;; 3.3. Suppose that our banking system requires the ability to make      ;;
;; joint accounts. Define a procedure make-joint that accomplishes        ;;
;; this. Make-joint should take three arguments. The first is a           ;;
;; password-protected account. The second argument must match the         ;;
;; password with which the account was defined in order for the           ;;
;; make-joint operation to proceed. The third argument is a new           ;;
;; password. Make-joint is to create an additional access to the original ;;
;; account using the new password. For example, if peter-acc is a bank    ;;
;; account with password open-sesame, then                                ;;
;;                                                                        ;;
;; (define paul-acc                                                       ;;
;;   (make-joint peter-acc 'open-sesame 'rosebud))                        ;;
;;                                                                        ;;
;; will allow one to make transactions on peter-acc using the name        ;;
;; paul-acc and the password rosebud. You may wish to modify your         ;;
;; solution to exercise 3.3 to accommodate this new feature.              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (make-account balance password)
  (let ((passwords (list password)))
    (define (withdraw amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient funds"))
    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)
    (define (call-the-cops) "Call the cops")
    (define (authenticate secret)
      (member secret passwords))

    (define (create-joint new-secret)
      (begin
        (set! passwords (cons new-secret passwords))
        dispatch))

    (define (dispatch secret m)
      (cond ((not (authenticate secret))
             (lambda x "Incorrect password"))
            ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            ((eq? m 'create-joint) create-joint)
            (else (error "Unknown request -- MAKE-ACCOUNT"
                         m))))
    dispatch))


(define (make-joint original-acc original-pass new-pass)
  ((original-acc original-pass 'create-joint) new-pass))

(define peter-acc (make-account 100 'secret-password))

(define paul-acc (make-joint acc2 'secret-password 'new-pass))

((paul-acc 'new-pass 'withdraw) 40)
;; 60

((paul-acc 'some-other-password 'deposit) 50)
;; "Incorrect password"
