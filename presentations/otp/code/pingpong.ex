ponger = spawn(fn ->
  receive do
    { :ping, sender } ->
      IO.puts "Received :ping, sending pong back to #{inspect sender}"
      send sender, :pong
  end
end)

IO.puts "sending ping to #{inspect ponger}"
send ponger, { :ping, self() }

receive do
  :pong -> 
    IO.puts "Got a pong back!"
after
  1_000 ->
    IO.puts "One second passed and no pong :("
end

