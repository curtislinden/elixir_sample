@docs """
	This module is defined as an Application. It is specified as the 
	module to invoke as an application in the mix.exs file.
"""

defmodule EgApplication do
  use Application

  @docs """
   This is the entry point for the Application.
   
   It starts a Supervisor Process.
  """
  def start(_type,_args) do
    Example.Supervisor.start_link
  end
end

