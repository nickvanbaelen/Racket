defmodule RacketTest do
  use ExUnit.Case
  doctest Racket

  test "greets the world" do
    assert Racket.hello() == :world
  end
end
