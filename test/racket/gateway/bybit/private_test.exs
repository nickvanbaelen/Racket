defmodule Racket.Gateway.ByBit.Private.Test do
  import Racket.Gateway.ByBit.Private

  use ExUnit.Case
  use Spec

  alias Racket.Gateway.Interface.Types.Currency
  alias Racket.Gateway.Interface.Types.CurrencyPair
  alias Racket.Gateway.Interface.Types.OrderExpiration
  alias Racket.Gateway.Interface.Types.OrderSide

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

    test "Invalid amount" do
      assert_raise Spec.Mismatch, fn -> account_leverage(CurrencyPair.BTCUSD, 200) end
    end

    test "Valid amounts" do
      account_leverage(CurrencyPair.BTCUSD, 1)
      account_leverage(CurrencyPair.EOSUSD, 10)
      account_leverage(CurrencyPair.ETHUSD, 23.51)
      account_leverage(CurrencyPair.XRPUSD, 50.0)

      leverage = account_leverage()

      assert leverage |> Map.get(CurrencyPair.BTCUSD.value()) |> Map.get("leverage") == 1
      assert leverage |> Map.get(CurrencyPair.EOSUSD.value()) |> Map.get("leverage") == 10
      assert leverage |> Map.get(CurrencyPair.ETHUSD.value()) |> Map.get("leverage") == 23.51
      assert leverage |> Map.get(CurrencyPair.XRPUSD.value()) |> Map.get("leverage") == 50.0
    end

    #TODO: Fix; this seems like a bug in the API, because ByBit web UI shows this as "cross"
    # test "Set cross margin for EOSUSD" do
    #   account_leverage("EOSUSD", 0)
    #   assert account_leverage() |> Map.get("EOSUSD") |> Map.get("leverage") == 0
    # end
  end

  describe "Placing a market order" do
    @describetag :api

    test "Invalid - BTCUSD BUY - Estimated buy liq_price cannot be higher than current mark_price" do
      assert { :error, 30022 } == place_market_order(OrderSide.BUY, CurrencyPair.BTCUSD, 1000000, OrderExpiration.IMMEDIATE_OR_CANCEL)
    end

    test "Invalid - BTCUSD SELL - Estimated sell liq_price cannot be higher than current mark_price" do
      assert { :error, 30023 } == place_market_order(OrderSide.SELL, CurrencyPair.BTCUSD, 1000000, OrderExpiration.IMMEDIATE_OR_CANCEL)
    end

    test "BTCUSD BUY" do
      { :ok, order } = place_market_order(OrderSide.BUY, CurrencyPair.BTCUSD, 100, OrderExpiration.IMMEDIATE_OR_CANCEL)

      assert Map.has_key?(order, "order_id")
      assert Map.get(order, "order_status") == "Created"
      assert Map.get(order, "reject_reason") == ""
    end

    test "BTCUSD SELL" do
      { :ok, order } = place_market_order(OrderSide.SELL, CurrencyPair.BTCUSD, 100, OrderExpiration.IMMEDIATE_OR_CANCEL)

      assert Map.has_key?(order, "order_id")
      assert Map.get(order, "order_status") == "Created"
      assert Map.get(order, "reject_reason") == ""
    end
  end

  describe "Placing a limit order" do
    @describetag :api
    @describetag :limit

    test "Invalid - BTCUSD BUY - Price exceeds minimum allowed" do
      assert_raise Spec.Mismatch, fn -> place_limit_order(OrderSide.BUY, CurrencyPair.BTCUSD, 0, 1000.0, OrderExpiration.IMMEDIATE_OR_CANCEL) end
    end

    test "Invalid - BTCUSD SELL - Price exceeds maximum allowed" do
      assert_raise Spec.Mismatch, fn -> place_limit_order(OrderSide.SELL, CurrencyPair.BTCUSD, 1000000, 1000.0, OrderExpiration.IMMEDIATE_OR_CANCEL) end
    end

    test "Valid - BTCUSD BUY" do
      { :ok, order } = place_limit_order(OrderSide.BUY, CurrencyPair.BTCUSD, 3000.0, 100, OrderExpiration.IMMEDIATE_OR_CANCEL)

      assert Map.has_key?(order, "order_id")
      assert Map.get(order, "order_status") == "Created"
      assert Map.get(order, "reject_reason") == ""
    end

    test "Valid - BTCUSD SELL" do
      { :ok, order } = place_limit_order(OrderSide.SELL, CurrencyPair.BTCUSD, 20000.0, 100, OrderExpiration.IMMEDIATE_OR_CANCEL)

      assert Map.has_key?(order, "order_id")
      assert Map.get(order, "order_status") == "Created"
      assert Map.get(order, "reject_reason") == ""
    end
  end
end
