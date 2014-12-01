defmodule Example.BenchmarkServerTest do
  use ExUnit.Case, async: true


  setup do

    {:ok, serverpid} = Example.BenchmarkServer.start_link()
    {:ok, server: serverpid}
  end


  test "tracks cost per call" , %{server: serverpid} do
    Example.BenchmarkServer.push_run(serverpid, 2)
    Example.BenchmarkServer.push_run(serverpid, 3)
    Example.BenchmarkServer.push_run(serverpid, 4)
    cost = Example.BenchmarkServer.average_cost_per_call(serverpid)
    assert cost == 3.0
  end

  test "tracks total run clock" , %{server: serverpid} do
    Example.BenchmarkServer.push_run(serverpid, 2)
    Example.BenchmarkServer.push_run(serverpid, 3)
    Example.BenchmarkServer.push_run(serverpid, 4)
    clock = Example.BenchmarkServer.total_clock(serverpid)
    assert clock == 9
  end


end

