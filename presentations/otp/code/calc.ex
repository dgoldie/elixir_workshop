defmodule Calc do

  def start do
    spawn(fn -> loop(0) end)
  end

  def loop x do
    receive do
      {:value, caller} - > 
        send caller, {:response, current_value}
        current_value

      {:add, caller} ->
        send caller, current_value + value

    end

  end


end
