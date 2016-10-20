
(display "What website do you want?")

; Notice the lack of Java type annotations
(let* ((name (read-line))
       (url (java.net.URL name))
       (stream #!null))
  ; dynamic-wind is like try-finally but more powerful; it protects if
  ; anything happens while the stream is open
  (dynamic-wind
      (lambda () (set! stream (url:openStream)))
      (lambda ()
        (let ((reader (java.io.BufferedReader (java.io.InputStreamReader stream))))
          ; Do-blocks are Scheme's go-to syntax for for/while-ish loops, such as
          ; iterating over the lines of a web page
          (do ((line (reader:readLine) (reader:readLine)))
              ((eq? line #!null))
            (display line))))
      (lambda () (or (eq? stream #!null)
                     (stream:close))))
  (display "\n"))
