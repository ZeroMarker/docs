% file: Example.lhs
% pdflatex Example.lhs
% pandoc -s Example.lhs -o Example.html
\documentclass{article}
\usepackage{literate}

\begin{document}
Here is some introductory text explaining the code below.

\begin{code}
module Main where

main :: IO ()
main = putStrLn "Hello, Literate Haskell!"
\end{code}
\end{document}
