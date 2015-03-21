defmodule Math do
  def square(x) do
    x * x
  end

  def sum(a, b) do
    a + b + extra
  end

  defp extra do
    5
  end




  # recursion
  def fact(0), do: 1
  def fact(n), do: n * fact(n - 1)

  def bizarro_factorial(n) do
    (1..n) |> Enum.reduce(&(&1 * &2))
  end
end
