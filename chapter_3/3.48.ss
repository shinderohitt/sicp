;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 3.48.  Explain in detail why the deadlock-avoidance method  ;;
;; described above, (i.e., the accounts are numbered, and each process  ;;
;; attempts to acquire the smaller-numbered account first) avoids       ;;
;; deadlock in the exchange problem. Rewrite serialized-exchange to     ;;
;; incorporate this idea. (You will also need to modify make-account so ;;
;; that each account is created with a number, which can be accessed by ;;
;; sending an appropriate message.)                                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; In this case, we put a *standard* restriction over how the resources   ;;
;; can be acquired by multiple, non-collaborating processes.              ;;
;;                                                                        ;;
;; Which is, processes can only acquire lower-numbered accounts first.    ;;
;;                                                                        ;;
;; Because of which, even though there are multiple required resources    ;;
;; to proceed, both processes will try to acquire the same account first. ;;
;; Only one of those will succeed, and other will fail. The failed one    ;;
;; cannot acquire the other resource because of the restriction. Hense,   ;;
;; it avoids the deadlock situation explained in the book                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Snippets given in the book
(define (make-account-and-serializer number balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((balance-serializer (make-serializer)))
    (define (dispatch m)
      (cond ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            ((eq? m 'balance) balance)
            ((eq? m 'number) number)
            ((eq? m 'serializer) balance-serializer)
            (else (error "Unknown request -- MAKE-ACCOUNT"
                         m))))
    dispatch))

(define (serialized-exchange account1 account2)
  (let ((serializer1 (account1 'serializer))
        (serializer2 (account2 'serializer)))
    ((serializer1 (serializer2 exchange))
     account1
     account2)))

;; serialized-exchange with explained restriction above
(define (serialized-exchange account1 account2)
  (let ((serializer1 (account1 'serializer))
        (serializer2 (account2 'serializer))
        (acc1-num (account1 'number))
        (acc2-num (account2 'number)))
    (if (< acc1-num acc2-num)
        ((serializer2 (serializer1 exchange))
         account1
         account2)
        ((serializer1 (serializer2 exchange))
         account1
         account2))))
