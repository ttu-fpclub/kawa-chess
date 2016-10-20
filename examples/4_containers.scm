
; Notice how tiny these class declarations are
; Compare to the length of the equivalent Java code

(define-simple-class Animal ()
  ((makeSound) #!abstract)
  ((speak)
   (display (makeSound))
   (display "\n")))

(define-simple-class Cow (Animal)
  ((makeSound) "Moo!"))

(define-simple-class Pig (Animal)
  ((makeSound) "Oink!"))

; We can store Java objects in Lisp arrays
(let ((animals (list (Cow) (Cow) (Pig) (Cow))))
  (for-each (lambda (an)
              ; Unfortunately, we get a compiler warning since Kawa can't "prove" that 'animals' consists
              ; only of Animal objects; this can be circumvented, but doing so is fairly verbose
              (an:speak))
            animals))

; The reverse is also true; we can store Lisp objects in Java collections
(let ((symbols (symbol[] 'first-element 'second-element 'third-element)))
  ; symbols is a Java array
  (display (symbols 1))
  (display "\n")
  (set! (symbols 1) 'changed-element)
  (display (symbols 1))
  (display "\n"))
