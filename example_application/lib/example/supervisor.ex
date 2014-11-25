defmodule Example.Supervisor do
  use Supervisor
  
  def start_link do
    # bit of a hack - naming it here
    Supervisor.start_link(__MODULE__, :ok, name: Example.Supervisor)
  end

  @output_server_name Example.OutputServer
  @input_server_name Example.InputServer
  @event_manager Example.EventHandler

  def init(:ok) do
    children_spec = [
      worker(Example.EventHandler, [[name: @event_manager]]),
      worker(Example.InputServer, [@event_manager,  [name: @input_server_name]]),
      worker(Example.OutputServer, [@event_manager, [name: @output_server_name]])
    ]
    supervise(children_spec, strategy: :one_for_one)
  end
end
