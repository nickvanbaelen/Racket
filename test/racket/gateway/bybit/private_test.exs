defmodule Racket.Gateway.ByBit.Private.Test do
  import Racket.Gateway.ByBit.Private

  use ExUnit.Case
  doctest Racket.Gateway.ByBit.Private

  test "User account balance" do
    assert Map.has_key?(account_balance("BTC"), "wallet_balance")
    assert Map.has_key?(account_balance("ETH"), "wallet_balance")
    assert Map.has_key?(account_balance("EOS"), "wallet_balance")
    assert Map.has_key?(account_balance("XRP"), "wallet_balance")
    assert Map.has_key?(account_balance("USDT"), "wallet_balance")
  end

  test "Set and retrieve user account leverage" do
    account_leverage("BTCUSD", 1)
    account_leverage("EOSUSD", 0)
    account_leverage("ETHUSD", 23.51)
    account_leverage("XRPUSD", 50.0)

    leverage = account_leverage()

    assert leverage |> Map.get("BTCUSD") |> Map.get("leverage") == 1
    assert leverage |> Map.get("EOSUSD") |> Map.get("leverage") == 0
    assert leverage |> Map.get("ETHUSD") |> Map.get("leverage") == 23.51
    assert leverage |> Map.get("XRPUSD") |> Map.get("leverage") == 50.0
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
