defmodule Racket.Gateway.ByBit.Spec.Test do
  import Racket.Gateway.ByBit.Spec

  alias Racket.Interface.Gateway.Types.Currency
  alias Racket.Interface.Gateway.Types.CurrencyPair
  alias Racket.Interface.Gateway.Types.OrderSide
  alias Racket.Interface.Gateway.Types.OrderType

  use ExUnit.Case

  doctest Racket.Gateway.ByBit.Spec

  describe "is_valid_currency" do
    for currency <- Currency.values() do
      test "#{currency}" do
        assert is_valid_currency?(unquote(currency))
      end
    end
  end

  describe "is_valid_currency_pair" do
    for currency_pair <- CurrencyPair.values() do
      test "#{currency_pair}" do
        assert is_valid_currency_pair?(unquote(currency_pair))
      end
    end
  end

  describe "is_valid_leverage" do
    for { symbols, max } <- [ { ["BTCUSD"], 100 }, { ["EOSUSD", "ETHUSD", "XRPUSD"], 50 } ] do
      for symbol <- symbols do
        test "#{symbol}" do
          assert 0                |> is_valid_leverage?(unquote(symbol))  # Cross
          assert 1                |> is_valid_leverage?(unquote(symbol))  # Non-leveraged
          assert 1.11             |> is_valid_leverage?(unquote(symbol))  # Fine grained leverage
          assert unquote(max)     |> is_valid_leverage?(unquote(symbol))  # Max leverage
          refute 0.5              |> is_valid_leverage?(unquote(symbol))  # 0 < leverage < 1
          refute unquote(max) + 1 |> is_valid_leverage?(unquote(symbol))  # max < leverage
          refute 5.001            |> is_valid_leverage?(unquote(symbol))  # Too fine grained leverage
        end
      end
    end
  end

  describe "is_valid_order_side" do
    for side <- OrderSide.values() do
      test "#{side}" do
        assert is_valid_order_side?(unquote(side))
      end
    end
  end

  describe "is_valid_order_type" do
    for type <- OrderType.values() do
      test "#{type}" do
        assert is_valid_order_type?(unquote(type))
      end
    end
  end
end
