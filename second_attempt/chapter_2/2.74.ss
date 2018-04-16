
;; We could use dispatch-on-type to retrieve records
;; where, the type would be department name. Each department
;; could have a "package" which specifies methods to access
;; files/records.

;; For instance, lets say there is a department named "computer",
;; we could add a package that would look something like --

(define (install-computer-dept)
  (define (get-record file emp-id)
    ;; code to retrieve the salary information
    )
  (define (get-salary file emp-id)
    (let (record (get-record file emp-id))
      ;; code to retrieve the salary from record
      ))

  ;; install definitions
  (put 'computer 'get-record get-record)
  (put 'computer 'get-salary get-salary))

;; To use it in a generic form, for all of the departments
(define (get-record dept file emp-id)
  ((get dept 'get-record) file emp-id))
(define (get-salary dept file emp-id)
  ((get dept 'get-salary) file emp-id))

;; To enable access for a new department/company,
;; we only need write & install separate packages for that,
;; which specified methods to access its own data (independent of
;; others)

;; for c.
;; assuming emp-id is employee name
;; also assuming, files is a list pairs of (file div-name)
;; or the division name could also be a function of file,
;; ie. (fn file) => department name.
;; The reason for this requirement is that we have mapped
;; access methods across department names.
(define (dept-name file) (car file))
(define (file-data file) (cdr file))

(define (find-employee-record files name)
  (if (null? files)
      #f
      (let* ((file (car files))
             (dept-name (dept-name file))
             (file-data (file-data file))
             (record (get-record dept-name file-data name)))
        (if record
            record
            (fine-employee-record (cdr files) name)))))
