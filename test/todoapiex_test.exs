defmodule TodoapiexTest do
  use ExUnit.Case
  doctest Todoapiex

  test "greets the world" do
    assert Todoapiex.hello() == :world
  end
end
