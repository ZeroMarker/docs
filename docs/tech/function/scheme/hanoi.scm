(define (tower-of-hanoi n source auxiliary target)
  (if (= n 1)
      (display (string-append "Move disk from " source " to " target "\n"))
      (begin
        (tower-of-hanoi (- n 1) source target auxiliary)
        (display (string-append "Move disk from " source " to " target "\n"))
        (tower-of-hanoi (- n 1) auxiliary source target))))

(tower-of-hanoi 3 "A" "B" "C")