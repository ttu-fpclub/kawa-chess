
(import (pos))
(import (chess))
(import (img))

(define +size+ 64)

(define *frame* :: javax.swing.JFrame
  #!null)

(define-simple-class Panel (javax.swing.JPanel)
  (pos init: '(0 0))
  ((*init*)
   (setPreferredSize (java.awt.Dimension +size+ +size+))
   (addMouseListener (object (java.awt.event.MouseAdapter)
                             ((mouseReleased (e :: java.awt.event.MouseEvent)) (react-to-click pos)))))
  ((paintComponent (graphics :: java.awt.Graphics))
   (let* ((darkened (odd? (+ (xvalue pos) (yvalue pos))))
          (color (cond
                  ((or (equal? pos (selected))
                       (can-legally-move? (selected) pos)) (if darkened
                                                               java.awt.Color:lightGray
                                                               java.awt.Color:white))
                  (else (if darkened
                            java.awt.Color:gray
                            java.awt.Color:yellow)))))
     (graphics:setColor color))
   (graphics:fillRect 0 0 +size+ +size+)
   (let ((at-pos (apply get-at pos)))
     (when (not (null? at-pos))
           (graphics:drawImage (get-image at-pos) 0 0 64 64 #!null)))))

(define-simple-class Frame (javax.swing.JFrame)
  (arr init-form: (make-array (shape 0 8 0 8) #!null))
  ((*init*)
   (setTitle "Game")))

(define (make-frame)
  (let ((frame (Frame))
        (layout (java.awt.GridLayout 8 8)))
    (let ((arr frame:arr))
      (do-board (pos '())
                (let ((panel (Panel)))
                  (set! panel:pos (list (yvalue pos) (xvalue pos)))
                  (array-set! arr (xvalue pos) (yvalue pos) panel)
            (frame:add panel)))
      (frame:setLayout layout)
      (frame:setDefaultCloseOperation frame:EXIT_ON_CLOSE)
      (frame:pack)
      (frame:show)
      frame)))

(define (set-title! (frame :: javax.swing.JFrame) str)
  (frame:setTitle str))

(define (make-default-frame)
  (set! *frame* (make-frame)))

(define (set-default-title! str)
  (set-title! *frame* str))

(define (set-appropriate-title!)
  (let ((base "Game")
        (turn (case (whose-turn)
                ((black) " - Black's Turn")
                ((white) " - White's Turn")
                (else "")))
        (check (if (in-check? (whose-turn))
                   " (Check!)"
                   "")))
    (set-title! *frame* (string-append base turn check))))

(define (force-redraw)
  (*frame*:repaint))

(define (react-to-click pos)
  (let ((y (yvalue pos))
        (x (xvalue pos)))
    (cond
     ((and (null? (selected))
           (eq? (get-color y x) (whose-turn)))
      (set-selected! (list y x)))
     ((and (not (null? (selected)))
           (can-legally-move? (selected) (list y x)))
      (full-move! (selected) (list y x))
      (force-redraw)
      (next-turn!)
      (set-selected! '()))
     ((not (null? (selected)))
      (set-selected! '())))
    (set-appropriate-title!)
    (force-redraw)))

(define (show-message str)
  (javax.swing.JOptionPane:showMessageDialog #!null str))

(define (exit-game)
  (*frame*:dispatchEvent (java.awt.event.WindowEvent *frame* java.awt.event.WindowEvent:WINDOW_CLOSING)))

(define (promotion-dialogue)
  (let ((buttons (string[] "Rook" "Knight" "Bishop" "Queen")))
    (let ((result (javax.swing.JOptionPane:showOptionDialog #!null "Promote your pawn!" "Pawn Promotion"
                                                            javax.swing.JOptionPane:DEFAULT_OPTION
                                                            javax.swing.JOptionPane:PLAIN_MESSAGE
                                                            #!null
                                                            buttons
                                                            "Rook")))
      (case result
        ((0) 'rook)
        ((1) 'knight)
        ((2) 'bishop)
        ((3) 'queen)
        (else (promotion-dialogue))))))

