defmodule Racket.Gateway.ByBit.Private.Test do
  import Racket.Gateway.ByBit.Private

  use ExUnit.Case
  use Spec

  alias Racket.Gateway.Interface.Types.Currency

  @moduletag :bybit

  doctest Racket.Gateway.ByBit.Private

  describe "Retrieving user account balance" do
    @describetag :api

    for currency <- Currency.enums() do
      test "#{currency}" do
        assert Map.has_key?(account_balance(unquote(currency)), "wallet_balance")
      end
    end
  end

  describe "Setting user account leverage" do
    @describetag :api

    test "Invalid symbol" do
      assert_raise Spec.Mismatch, fn -> account_leverage("XTZUSD", 1) end
    end

    test "Invalid amount" do
      assert_raise Spec.Mismatch, fn -> account_leverage("BTCUSD", 200) end
    end

    test "Valid symbols and amounts" do
      account_leverage("BTCUSD", 1)
      account_leverage("EOSUSD", 10)
      account_leverage("ETHUSD", 23.51)
      account_leverage("XRPUSD", 50.0)

      leverage = account_leverage()

      assert leverage |> Map.get("BTCUSD") |> Map.get("leverage") == 1
      assert leverage |> Map.get("EOSUSD") |> Map.get("leverage") == 10
      assert leverage |> Map.get("ETHUSD") |> Map.get("leverage") == 23.51
      assert leverage |> Map.get("XRPUSD") |> Map.get("leverage") == 50.0
    end

    #TODO: Fix; this seems like a bug in the API, because ByBit web UI shows this as "cross"
    # test "Set cross margin for EOSUSD" do
    #   account_leverage("EOSUSD", 0)
    #   assert account_leverage() |> Map.get("EOSUSD") |> Map.get("leverage") == 0
    # end
  end

  describe "Placing a market order" do
    @describetag :api

    #TODO: Create test with a market order than cannot be fulfilled, how to handle failure?

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
end
