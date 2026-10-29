defmodule MathFunctions do
  def factorial(0), do: 1
  def factorial(n), do: n * factorial(n - 1)
end

# Example usage
IO.puts MathFunctions.factorial(7)
