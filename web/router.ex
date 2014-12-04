defmodule ElixirExample.Router do
@docmodule """
  Phonex Router is used to map request PATH to Controllers.
"""
  use Phoenix.Router

  scope "/" do

    get "/default", ElixirExample.PageController, :index, as: :pages
    get "/index", ElixirExample.BasicController,       :index, as: :basic
  end

  scope "/api" do
    post "/basic", ElixirExample.BasicController, :index, as: :api_basic
  end

  # Other scopes may use custom stacks.
  # scope "/api" do
  #   pipe_through :api
  # end
end
