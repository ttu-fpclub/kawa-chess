
; To use Java Swing, subclass JFrame like you would in Java
(define-simple-class Frame (javax.swing.JFrame)
  ((*init*)
   (setTitle "This is a window!")
   (setDefaultCloseOperation EXIT_ON_CLOSE)
   (setLayout (java.awt.FlowLayout java.awt.FlowLayout:CENTER 20 20))))

; JOptionPane is also really easy
(define (show-message str)
  (javax.swing.JOptionPane:showMessageDialog #!null str))

(let ((frame (Frame)))
  ; Adding components is equally straightforward
  (frame:add (javax.swing.JButton "This button does nothing"))
  ; Anonymous classes are convenient as well
  (frame:add (object (javax.swing.JButton java.awt.event.ActionListener)
                     ((*init*)
                      (setLabel "This button will show you something")
                      (addActionListener (this)))
                     ((actionPerformed e)
                      (show-message "You clicked a button! Congrats!"))))
  ; Kawa has a beautiful syntax for action listeners and similar abstract interfaces
  (frame:add (let ((obj (javax.swing.JButton "This button is really convenient")))
               (obj:addActionListener (lambda (e)
                                        ; Yes, this is a lambda that is pretending to be an ActionListener
                                        (show-message "You clicked the second button!")))
               obj))
  (frame:pack)
  (frame:show))
