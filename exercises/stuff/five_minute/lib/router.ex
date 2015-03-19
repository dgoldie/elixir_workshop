defmodule YourApp.Router do
  use Phoenix.Router

  scope alias: YourApp do
    get "/pages/:page", PageController, :show
    get "/files/*path", FileController, :show

    resources "/users", UserController do
      resources "/comments", CommentController
    end
  end



  defp do_match("GET", "/resource1", conn) do
    ...
  end

  defp do_match("POST", "/resource2", conn) do
    ...
  end
end

