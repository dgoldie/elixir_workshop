defmodule MyList do


  def map([h|t], fun) do
    [fun.(h) | map(t,fun)]
  end

  def map([], _) do
    []
  end

  def reduce([head | tail], fun) do
    reduce(tail, head, fun)
  end

  def reduce(list, initial, fun) do
    do_reduce(list, fun, initial)
  end

  defp do_reduce([h | t], fun, acc) do
    do_reduce(t, fun, fun.(h, acc) )
  end

  defp do_reduce([], _, acc), do: acc
end
