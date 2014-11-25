defmodule Example.EventHandlerTest do
  use ExUnit.Case, async: true
  import Mock

  test " Given a proccess_input event and an document it sends dispatch_output to OutputServer Server" do
    document = %{document_id: 0xDEADBEEF}
    {:ok, pid_event} = GenEvent.start_link
    GenEvent.add_mon_handler(pid_event, Example.EventHandler, [])
    with_mock Example.OutputServer, [dispatch_output: fn(server,document) -> true end] do
      GenEvent.sync_notify(pid_event, {:processed_input, document})
      assert(called(Example.OutputServer.dispatch_output(Example.OutputServer,document)))
    end

  end

  test " Given a error_output_output_dispatch event and an document it sends dispatch_output to OutputServer Server with error count" do
    document = %{document_id: 0xDEADBEEF}
    error_count = 1
    {:ok, pid_event} = GenEvent.start_link
    GenEvent.add_mon_handler(pid_event, Example.EventHandler, [])
    with_mock Example.OutputServer, [dispatch_output: fn(server,document, errc) -> true end] do
      GenEvent.sync_notify(pid_event, {:error_input_output_dispatch, document, error_count})
      assert(called(Example.OutputServer.dispatch_output(Example.OutputServer,document, error_count)))
    end

  end
  
end
