defmodule ElixirExample.BasicController do
  use Phoenix.Controller
  alias Poison, as: JSON
  
  plug :action
  @docs """
  	Type: GET

  	Response: 
  		Content-Type: application/json
  		Contains: Get Params with additional parameter 'sent'

  	This action passes the HTTP Params map into the a module of the 'ExampleApplication' Elixir ExampleApplication
  	that expectso to process a document in map/dict form.
  
  """
  def index(conn,_params) do
    Example.InputServer.process_input(Example.InputServer,_params)
    response = Dict.put(_params,:sent, true)

    json conn, JSON.encode!(response)
  end
end
