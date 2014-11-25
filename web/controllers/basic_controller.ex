defmodule ElixirExample.BasicController do
  use Phoenix.Controller
  alias Poison, as: JSON
  
  plug :action

  def index(conn,_params) do
    Example.InputServer.process_input(Example.InputServer,_params)
    response = Dict.put(_params,:sent, true)

    json conn, JSON.encode!(response)
  end
end
