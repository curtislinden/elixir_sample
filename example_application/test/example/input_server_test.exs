defmodule Example.InputServerTest do
  use ExUnit.Case, async: true

  defmodule Forwarder do
    use GenEvent

    def handle_event(event, parent) do
      send parent, event
      {:ok, parent}
    end
  end

  setup do
  
    {:ok, event_mananger} = GenEvent.start_link()
    GenEvent.add_mon_handler(event_mananger,Forwarder, self())

    {:ok, serverpid} = Example.InputServer.start_link(event_mananger)
    {:ok, commerce_engine: serverpid}
  end

  test "Example procceded document returns ok status" , %{commerce_engine: serverpid} do
    document = %{document_id: 0xdeadbeef}
    processed_input =  Example.InputServer.process_input_sync(serverpid, document)
    assert processed_input[:processed] == true
  end
  
  test "Example  Async Proccessing generates event 'processed_input' " , %{commerce_engine: serverpid} do
    document = %{document_id: 0xdeadbeef}
    Example.InputServer.process_input(serverpid, document)
    processed_input = Dict.put(document, :processed, true )
    assert_receive    {:processed_input, ^processed_input}
  end

  test "document count" , %{commerce_engine: serverpid} do
    document = %{document_id: 0xdeadbeef}
    Example.InputServer.process_input_sync(serverpid, document)
    Example.InputServer.process_input_sync(serverpid, document)
    Example.InputServer.process_input_sync(serverpid, document)
    Example.InputServer.process_input_sync(serverpid, document)
    call_count = Example.InputServer.call_count(serverpid)
    assert call_count == 4
  end


end
