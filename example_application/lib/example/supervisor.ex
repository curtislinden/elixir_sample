@docs """
  This module defines the process tree for this application 'example_application'

  Specifically at this point there is an EventHandler process, an InputServer and an OuputServer process
  that are running as workers of this Supervisor Process.
  
"""
defmodule Example.Supervisor do
  use Supervisor
  
  @docs """
    Naming the process here to make it easy to access the process.
  """
  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: Example.Supervisor)
  end

  @output_server_name Example.OutputServer
  @input_server_name Example.InputServer
  @event_manager Example.EventHandler


  @docs """
    This method follows the interface for the Supervisor behavior.

    The child spec is part of the OTP definintion of a supervisor and
    in elixir the macro 'worker(module, [arguments, [options]])' assists
    in generating a worker spec to configure which modules should be started
    and monitored by the supervisor.

    In this instance the supervisor will restart any process that fails over again.

  """
  def init(:ok) do
    children_spec = [
      worker(Example.EventHandler, [[name: @event_manager]]),
      worker(Example.InputServer, [@event_manager,  [name: @input_server_name]]),
      worker(Example.OutputServer, [@event_manager, [name: @output_server_name]])
    ]
    supervise(children_spec, strategy: :one_for_one)
  end
end
