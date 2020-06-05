defmodule Racket.Application.Test do
  use ExUnit.Case
  doctest Racket.Application

  test "greets the world" do
    assert Racket.hello() == :world
  end
end
