defmodule Basic do

  def hello(x \\ "<anonymous>") do
    IO.puts "hello #{x}"
  end

  def spawn_hello do
    IO.puts "spawn_hello, #{inspect self}"
    receive do
      {sender, msg} ->
        send sender, {:ok, "hello #{msg}" }
      {sender} ->
        send sender, {:ok, "hello <anonymous>"}
    end
    spawn_hello
  end





  #####
  def sleepy(x) do
    :timer.sleep(2000)
    "message no. #{x}"
  end

  def async_msg(x) do
    spawn(fn -> IO.puts(sleepy(x)) end )
  end





end
