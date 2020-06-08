defmodule Racket.Gateway.ByBit.Private.Test do
  import Racket.Gateway.ByBit.Private

  use ExUnit.Case
  doctest Racket.Gateway.ByBit.Private

  test "wallet_balance" do
    assert Map.has_key?(wallet_balance("BTC"), "wallet_balance")
    assert Map.has_key?(wallet_balance("ETH"), "wallet_balance")
    assert Map.has_key?(wallet_balance("EOS"), "wallet_balance")
    assert Map.has_key?(wallet_balance("XRP"), "wallet_balance")
    assert Map.has_key?(wallet_balance("USDT"), "wallet_balance")
  end
end
