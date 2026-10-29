; my_program.scm
(define (square x)
  (* x x))

(display "Enter a number: ")
(define num (read))
(display "The square of ")
(display num)
(display " is ")
(display (square num))
(newline)
(exit)