defmodule Tcprpc.Server do
  use GenServer

  defmodule State do
    defstruct port: nil, lsock: nil, request_count: 0
  end

  def start_link(port) do
    GenServer.start_link({ :local, :tcprcp }, __MODULE__, port, [])
  end

  def start_link() do
    start_link 1055
  end

  def get_count() do
    GenServer.call(:tcprcp, :get_count)
  end

  def stop() do
    GenServer.cast(:tcprcp, :stop)
  end

  def init (port) do
    { :ok, lsock } = :gen_tcp.listen(port, [{ :active, true }])
    { :ok, State.new(lsock: lsock, port: port), 0 }
  end

  def handle_call(:get_count, _from, state) do 
    { :reply, { :ok, state.request_count }, state }
  end

  def handle_cast(:stop , state) do
    { :noreply, state }
  end

  def handle_info({ :tcp, socket, raw_data}, state) do
    do_rpc socket, raw_data
    { :noreply, state.update_request_count(fn(x) -> x + 1 end) } # inc?
  end

  def handle_info(:timeout, state = State[lsock: lsock]) do
    { :ok, _sock } = :gen_tcp.accept lsock
    { :noreply, state }
  end

  def do_rpc(socket, raw_data) do
    try do
      result = Code.eval_string(raw_data)
      :gen_tcp.send(socket, :io_lib.fwrite("~p~n", [result]))
    catch
      error -> :gen_tcp.send(socket, :io_lib.fwrite("~p~n", [error]))
    end
  end

end
