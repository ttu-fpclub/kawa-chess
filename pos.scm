
(define (sgn z)
  (cond
   ((< z 0) -1)
   ((> z 0)  1)
   (else     0)))

(define (position y x)
  (list y x))

(define (yvalue pos)
  (car pos))

(define (xvalue pos)
  (car (cdr pos)))

(define (++ pos1 pos0)
  (position (+ (yvalue pos1) (yvalue pos0))
            (+ (xvalue pos1) (xvalue pos0))))

(define (-- pos1 pos0)
  (position (- (yvalue pos1) (yvalue pos0))
            (- (xvalue pos1) (xvalue pos0))))
