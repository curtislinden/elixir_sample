defmodule ElixirExample.Router do
  use Phoenix.Router

  scope "/" do
    # Use the default browser stack.
    pipe_through :browser

    get "/default", ElixirExample.PageController, :index, as: :pages
    get "/", ElixirExample.BasicController,       :index, as: :basic
  end

  scope "/api" do
    # Use the default browser stack.
    pipe_through :api
    get "/basic", ElixirExample.BasicController,       :index, as: :basic
  end

  # Other scopes may use custom stacks.
  # scope "/api" do
  #   pipe_through :api
  # end
end
