defmodule Parallel do
  def first_pmap(collection, fun) do
    me = self
    collection
    |> Enum.map(fn (elem) ->
         spawn_link fn -> (send me, { self, fun.(elem) }) end
       end)
    |> Enum.map(fn (pid) ->
         receive do { ^pid, result } -> result end
       end) 
  end

    def pmap(collection, func) do
      collection
      |> Enum.map(&(Task.async(fn -> func.(&1) end))) 
      |> Enum.map(&Task.await/1)
    end

# We could run this function to get the squares of the numbers from 1 to 1000.
# result = Parallel.pmap 1..1000, &(&1 * &1)

end
