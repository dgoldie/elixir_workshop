defmodule Chain do
  @moduledoc """
  Spawns Erlangs's lightweight processes for counting up numbers.
  """
 
  # When receiving a number from the previous process, 'receive' block is executed with number 'n'.
  # Then, propagate the 'n + 1' to the next process.
  def counter(next_pid) do
    receive do
      n -> send next_pid, n + 1
    end
  end
 
  # Creates 'n' number of processes to count upto 'n'
  def create_processes(n) do
    # loop 'n' times to spawn processes, then returns the process id of last one, which comprises
    # of 'n' process chain starting from 'self' process.
    last = Enum.reduce 1..n, self,
             fn(_, send_to) -> spawn(Chain, :counter, [send_to]) end
 
    # send the initial number 0 to the last process.
    send last, 0
 
    # wait for the 'n' length propagation to complete back to 'self'
    receive do
      final_answer when is_integer(final_answer) ->
        "Result is #{inspect(final_answer)}"
    end
  end
 
  # Execute the process creation with the timer count.
  def run(n) do
    {time, msg} = :timer.tc(Chain, :create_processes, [n])
    IO.puts "time = #{div(time, 1000)} milliseconds, msg = #{msg}"
  end
end
 
# spawning 10000 processes which each counts up one.
Chain.run(10000)
