
(define (load-image (str :: string))
  (javax.imageio.ImageIO:read (java.io.File str)))

(define *images* `(((black    pawn) ,(load-image  "bp.png"))
                   ((white    pawn) ,(load-image  "wp.png"))
                   ((black  bishop) ,(load-image  "bb.png"))
                   ((white  bishop) ,(load-image  "wb.png"))
                   ((black  knight) ,(load-image  "bn.png"))
                   ((white  knight) ,(load-image  "wn.png"))
                   ((black    rook) ,(load-image  "br.png"))
                   ((white    rook) ,(load-image  "wr.png"))
                   ((black   queen) ,(load-image  "bq.png"))
                   ((white   queen) ,(load-image  "wq.png"))
                   ((black    king) ,(load-image  "bk.png"))
                   ((white    king) ,(load-image  "wk.png"))))

(define (get-image datum)
  (car (cdr (assoc datum *images*))))

