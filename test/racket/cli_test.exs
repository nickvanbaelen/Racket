defmodule Racket.CLI.Test do
  use ExUnit.Case
  doctest Racket.CLI

  test "Parse empty arguments" do
    assert nil == Racket.CLI.parse_args([])
  end

  test "Parse help switch" do
    assert :help == Racket.CLI.parse_args(["--help"])
    assert :help == Racket.CLI.parse_args(["-h"])
  end

  test "Parse unknown arguments" do
    assert :help == Racket.CLI.parse_args(["unknown"])
    assert :help == Racket.CLI.parse_args(["--test"])
  end
end
