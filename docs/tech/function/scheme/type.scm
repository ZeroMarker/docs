; (boolean? #t)              =>  #t
; (boolean? "Hello, World!") =>  #f

#|
(number? 42)       =>  #t
(number? #t)       =>  #f
(complex? 2+3i)    =>  #t
(real? 2+3i)       =>  #f
(real? 3.1416)     =>  #t
(real? 22/7)       =>  #t
(real? 42)         =>  #t
(rational? 2+3i)   =>  #f
(rational? 3.1416) =>  #t
(rational? 22/7)   =>  #t
(integer? 22/7)    =>  #f
(integer? 42)      =>  #t

(eqv? 42 42)   =>  #t
(eqv? 42 #f)   =>  #f
(eqv? 42 42.0) =>  #f

(= 42 42)   =>  #t
(= 42 #f)   -->ERROR!!!
(= 42 42.0) =>  #t
|#

#|
(char? #\c) =>  #t
(char? 1)   =>  #f
(char? #\;) =>  #t
|#

#|
(quote xyz)
=>  xyz

(define xyz 9)
(set! xyz #\c)
|#

; String
#|
(define greeting "Hello; Hello!")
(string-ref greeting 0)
=>  #\H
|#

; Vector
; (define v (make-vector 5))

