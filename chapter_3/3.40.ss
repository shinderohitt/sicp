;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Exercise 3.40.  Give all possible values of x that can result from executing ;;
;;                                                                              ;;
;; (define x 10)                                                                ;;
;;                                                                              ;;
;; (parallel-execute (lambda () (set! x (* x x)))                               ;;
;;                   (lambda () (set! x (* x x x))))                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 1,000,000: P1 sets x to 100. P2 sets x to 1000,000             ;;
;;                                                                ;;
;; 1,000,000: P2 sets x to 1000. P1 sets x to 1000,000            ;;
;;                                                                ;;
;; 100: After P1 accesses x twice (* x x), P2 finishes,           ;;
;;      setting x to 1000. After which, P1 sets it to 100.        ;;
;;                                                                ;;
;; 1000: After P2 accesses x thrice (* x x x), P1 finishes,       ;;
;; setting x to 100. After which, P2 sets it to 1000.             ;;
;;                                                                ;;
;; 100,000: After P1 accesses x once (in (* x x)), P2 finishes    ;;
;; setting x to 1000. Hence, P1 reads x as 1000 second time.      ;;
;; Which causes x to end up as 1000,00.                           ;;
;;                                                                ;;
;; 100,000: After P2 accesses x onces (in (* x x x)), P1 finishes ;;
;; setting x to 100. Hence, P2's two consecutive reads are 100.   ;;
;;                                                                ;;
;; 10,000:  After P2 accesses x twice (in (* x x x)), P1 finishes ;;
;; setting x to 100. Hence, P2's last consecutive read is 100.    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Which of these possibilities remain if we instead use serialized              ;;
;; procedures:                                                                   ;;
;;                                                                               ;;
;; (define x 10)                                                                 ;;
;;                                                                               ;;
;; (define s (make-serializer))                                                  ;;
;;                                                                               ;;
;; (parallel-execute (s (lambda () (set! x (* x x))))                            ;;
;;                   (s (lambda () (set! x (* x x x)))))                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; After serialization it can only result in 1,000,000 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
