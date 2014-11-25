defmodule Example.SupervisorTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, process: Example.Supervisor}
  end

  test "The supervisor registers Example.InputServer by name" do
    assert Enum.member?(Process.registered,Example.InputServer)
  end

  test "The supervisor registers Example.OutputServer by name" do
    assert Enum.member?(Process.registered,Example.OutputServer)
  end

  test "The supervisor registers Example.EngineEventHandler by name" do
    assert Enum.member?(Process.registered,Example.EventHandler)
  end

  test "The supervisor starts Example.InputServer" do
    assert Process.alive?(Process.whereis(Example.InputServer))
  end

  test "The supervisor starts Example.OutputServer" do
    assert Process.alive?(Process.whereis(Example.InputServer))
  end

  test "The supervisor starts Example.EventManager" do
    assert Process.alive?(Process.whereis(Example.EventHandler))
  end

end
