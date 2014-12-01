defmodule EgApplication do
  use Application

  @doc """
   This is the entry point for the Application.

   It starts a Supervisor Process.
  """
  def start(_type,_args) do
    Example.Supervisor.start_link
  end
end

