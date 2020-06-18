defmodule Racket.Gateway.ByBit.Spec.Test do
  import Racket.Gateway.ByBit.Spec

  alias Racket.Gateway.Interface.Types.CurrencyPair

  use ExUnit.Case

  @moduletag :bybit

  doctest Racket.Gateway.ByBit.Spec

  describe "is_valid_leverage" do
    for { currency_pair, max } <- [ { CurrencyPair.BTCUSD, 100 },
                                    { CurrencyPair.EOSUSD, 50 },
                                    { CurrencyPair.ETHUSD, 50 },
                                    { CurrencyPair.XRPUSD, 50 } ] do
      test "#{currency_pair}" do
        assert 0                |> is_valid_leverage?(unquote(currency_pair))  # Cross
        assert 1                |> is_valid_leverage?(unquote(currency_pair))  # Non-leveraged
        assert 1.11             |> is_valid_leverage?(unquote(currency_pair))  # Fine grained leverage
        assert unquote(max)     |> is_valid_leverage?(unquote(currency_pair))  # Max leverage
        refute 0.5              |> is_valid_leverage?(unquote(currency_pair))  # 0 < leverage < 1
        refute unquote(max) + 1 |> is_valid_leverage?(unquote(currency_pair))  # max < leverage
        refute 5.001            |> is_valid_leverage?(unquote(currency_pair))  # Too fine grained leverage
      end
    end
  end

  describe "is_valid_price" do
    for { currency_pair, { min, max, tick_size } } <- [ { CurrencyPair.BTCUSD, { 0.5, 999999.5, 0.5 } },
                                                        { CurrencyPair.ETHUSD, { 0.05, 99999.95, 0.05 } },
                                                        { CurrencyPair.EOSUSD, { 0.001, 1999.999, 0.001 } },
                                                        { CurrencyPair.XRPUSD, { 0.0001, 199.9999, 0.0001 } } ] do
      test "#{currency_pair}" do
        assert unquote(min)                             |> is_valid_order_price?(unquote(currency_pair))
        assert unquote(max)                             |> is_valid_order_price?(unquote(currency_pair))
        refute unquote(min) - unquote(tick_size)        |> is_valid_order_price?(unquote(currency_pair)) # order_price < min
        refute unquote(max) + unquote(tick_size)        |> is_valid_order_price?(unquote(currency_pair)) # max < order_price
        refute unquote(min) + (unquote(tick_size) / 10) |> is_valid_order_price?(unquote(currency_pair)) # Too fine grained price
      end
    end
  end
end
