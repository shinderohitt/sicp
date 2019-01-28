;; 2
(define (make-save inst machine stack pc)
  (let* ((source-register-name (stack-inst-reg-name inst))
         (reg (get-register machine source-register-name)))
    (lambda ()
      (push stack (cons source-register-name (get-contents reg)))
      (advance-pc pc))))

(define (make-restore inst machine stack pc)
  (let* ((target-register-name (stack-inst-reg-name inst))
         (reg (get-register machine target-register-name)))
    (lambda ()
      (let ((popped (pop stack)))
        (if (eq? target-register-name (car popped))
            (begin
              (set-contents! reg (cdr popped))
              (advance-pc pc))
            (error "ERROR: RESTORE with invalid register"))))))

;; 3
;; Storing the associative list in machine model. Stacks could be
;; a part of the register model too.
;; A modified version of make-new-machine to handle register-stacks
;; A basic (modified) machine
(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack-table '())
        (the-instruction-sequence '()))
    (let ((the-ops
           (list
            (list 'initialize-stack
                  (lambda ()
                    (for-each
                     (lambda (stack)
                       ;; Get the stack object for each register
                       ;; and initialize
                       ((cadr stack) 'initialize))
                     stack-table)))))
          (register-table
           (list (list 'pc pc)
                 (list 'flag flag))))
      (define (allocate-register name)
        (if (assoc name register-table)
            (error
             "Multiply defined register: "
             name)
            (begin
              (set! register-table
                (cons
                 (list name
                       (make-register name))
                 register-table))
              (set! stack-table
                (cons
                 (list name
                       (make-stack))
                 stack-table))))
        'register-allocated)
      (define (lookup-register name)
        (let ((val
               (assoc name register-table)))
          (if val
              (cadr val)
              (error "Unknown register:"
                     name))))
      (define (lookup-stack name)
        (let ((val
               (assoc name stack-table)))
          (if val
              (cadr val)
              (error "Unknown register:"
                     name))))
      (define (execute)
        (let ((insts (get-contents pc)))
          (if (null? insts)
              'done
              (begin
                ((instruction-execution-proc
                  (car insts)))
                (execute)))))
      (define (dispatch message)
        (cond ((eq? message 'start)
               (set-contents!
                pc
                the-instruction-sequence)
               (execute))
              ((eq?
                message
                'install-instruction-sequence)
               (lambda (seq)
                 (set!
                     the-instruction-sequence
                   seq)))
              ((eq? message
                    'allocate-register)
               allocate-register)
              ((eq? message 'get-register)
               lookup-register)
              ((eq? message 'get-stack)
               lookup-stack)
              ((eq? message
                    'install-operations)
               (lambda (ops)
                 (set! the-ops
                   (append the-ops ops))))
              ((eq? message 'stack) stack-table)
              ((eq? message 'operations)
               the-ops)
              (else (error "Unknown request:
                            MACHINE"
                           message))))
      dispatch)))

;; Also need to modify make-save, and make-restore
(define (make-save inst machine stack pc)
  (let* ((register-name (stack-inst-reg-name inst))
         (reg (get-register machine register-name))
         (stack (get-stack machine register-name)))
    (lambda ()
      (push stack (get-contents reg))
      (advance-pc pc))))

(define (make-restore inst machine stack pc)
  (let* ((register-name (stack-inst-reg-name inst))
         (reg (get-register machine register-name))
         (stack (get-stack machine register-name)))
    (lambda ()
      (set-contents! reg (pop stack))
      (advance-pc pc))))

;; A wrapper
(define (get-stack machine reg-name)
  ((machine 'get-stack) reg-name))
