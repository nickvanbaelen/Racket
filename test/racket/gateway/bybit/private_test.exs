defmodule Racket.Gateway.ByBit.Private.Test do
  import Racket.Gateway.ByBit.Private

  use ExUnit.Case
  doctest Racket.Gateway.ByBit.Private

  test "wallet_balance" do
    IO.inspect(wallet_balance("BTC"))
  end
end
