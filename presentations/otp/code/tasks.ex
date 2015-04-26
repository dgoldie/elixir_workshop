defmodule Tasks do

  def squared_numbers_list x do
    1..x |> Enum.map( &(&1 * &1))
  end

  IO.puts "start the task"
  worker = Task.async(fn -> Tasks.squared_numbers_list(10) end)
  IO.puts "do something else"

  #...
  IO.puts "wait for task"
  result = Task.await(worker)

  IO.puts "The result is #{inspect result}"

end
