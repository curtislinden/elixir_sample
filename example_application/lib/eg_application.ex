defmodule EgApplication do
  use Application
  def start(_type,_args) do
    Example.Supervisor.start_link
  end
end

