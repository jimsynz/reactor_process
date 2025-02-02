defmodule Reactor.SupervisorTest do
  use ExUnit.Case
  doctest Reactor.Supervisor

  test "greets the world" do
    assert Reactor.Supervisor.hello() == :world
  end
end
