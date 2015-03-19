defmodule Parallel do
  def pmap(collection, func) do
    collection
    |> Enum.map(&(Task.async(fn -> func.(&1) end))) 
    |> Enum.map(&Task.await/1)
  end
end

# We could run this function to get the squares of the numbers from 1 to 1000.
# result = Parallel.pmap 1..1000, &(&1 * &1)
