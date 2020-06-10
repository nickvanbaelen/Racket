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

  describe "Placing a market order" do
    test "BTCUSD market buy order" do
      order = place_market_order("Buy", "BTCUSD", 100, "ImmediateOrCancel")

      assert Map.has_key?(order, "order_id")
      assert Map.get(order, "order_status") == "Created"
      assert Map.get(order, "reject_reason") == ""
    end

    test "BTCUSD market sell order" do
      order = place_market_order("Sell", "BTCUSD", 100, "ImmediateOrCancel")

      assert Map.has_key?(order, "order_id")
      assert Map.get(order, "order_status") == "Created"
      assert Map.get(order, "reject_reason") == ""
    end
end
