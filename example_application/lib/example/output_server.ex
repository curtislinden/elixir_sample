defmodule Example.OutputServer do
  require Logger
  
  alias Poison, as: JSON

  use GenServer
  def start_link(event_manager, opts \\ []) do
    GenServer.start_link(__MODULE__, event_manager, opts)
  end


  @docs """

   Initialize server with default state:
   {:ok, %{gun: pid}}

   Successful initialization will result in using
   the output_external_host , output_external_port and
   :output_gun_opts definde in the mix file application env
   to open a gun process.

   The gun process will become part of server state
  """
  def init(event_manager) do
    host = Application.get_env(:example_application,:output_external_host)
    port = Application.get_env(:example_application,:output_external_port)
    {:ok , %{event_manager: event_manager, host: host, port: port}}
  end
  
  @docs """
    Dispatch a remote service call via cast to the configured remote server
    the document parameter will be converted to a JSON post body
  """
  def dispatch_output(server,document) do
    dispatch_output(server,document,0)
  end

  def dispatch_output(server,document, error_count) do
    GenServer.cast(server, {:dispatch_output, document, error_count})
  end

  def handle_cast({:dispatch_output, document, error_count}, state) do
    uri     = "http://#{state.host}:#{state.port}/document"
    payload = JSON.encode!(document)

    case HTTPoison.post(uri,payload) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Logger.info body
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        Logger.error "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error reason
        Logger.error "resubmitting document"
        Logger.error state.event_manager

        GenEvent.notify(state.event_manager,{:error_input_output_dispatch, document, error_count + 1})

    end

    {:noreply, state}
  end

end