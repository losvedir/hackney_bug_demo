defmodule HackneyBugDemoTest do
  use ExUnit.Case
  doctest HackneyBugDemo

  test "greets the world" do
    assert HackneyBugDemo.hello() == :world
  end
end
