defmodule Parallel do
  # Allows mapping over a collection using N parallel processes
  def pmap(collection, function) do
    # Get this process's PID
    me = self
    collection
    |> Enum.map(fn (elem) ->
      # For each element in the collection, spawn a process and
      # tell it to:
      # - Run the given function on that element
      # - Call up the parent process
      # - Send the parent its PID and its result
      # Each call to spawn_link returns the child PID immediately.
      spawn_link fn -> (send me, { self, function.(elem) }) end
    end) 

    # Here we have the complete list of child PIDs. We don't yet know
    # which, if any, have completed their work
    |> Enum.map(fn (pid) ->
      # For each child PID, in order, block until we receive an
      # answer from that PID and return the answer
      # While we're waiting on something from the first pid, we may
      # get results from others, but we won't "get those out of the
      # mailbox" until we finish with the first one.
      receive do { ^pid, result } -> result end
    end)
  end
end

# Parallel.pmap(1..1_000, fn(integer) -> integer * integer end)
