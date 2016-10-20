
; This is a genuine Java class and can be treated as such
(define-simple-class Person ()
  ; In true Lisp spirit, fields are public by default
  (name init: "John Smith")
  ; Restricted access fields are available, however
  (ssn init: '123-45-6789 access: 'private)
  ; Constructors follow the same rules as in Java; if none are specified, a default one exists
  ((*init* pname pssn)
   ; You can just "pretend" the instance variables are in scope, like you can in Java and C++
   (set! name pname)
   (set! ssn pssn))
  ; Getters are easy to write in Scheme's concise function syntax
  ((getSSN)
   ssn)
  ; Overriding methods is equally easy
  ((toString)
   ((string-append "[Person " (name:toString) " " ((getOccupation):toString) "]"):toString))
  ; Lisp types and Java types can be pretty freely mixed
  ((getOccupation)
   'none))

; Subclassing works just the way you'd expect
(define-simple-class Student (Person)
  ; Need constructor since Person has no default one
  ((*init* name ssn)
   (invoke-special Person (this) '*init* name ssn))
  ; Overriding parent method
  ((getOccupation)
   'student))

; Constructors are called simply using the class name as the function name
(let ((per (Person "Steve" '111-11-1111))
      (stu (Student "Jack" '222-22-2222)))
  (display per)
  (display stu)
  (display "\n"))
