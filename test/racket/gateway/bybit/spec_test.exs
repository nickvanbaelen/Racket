defmodule Racket.Gateway.ByBit.Spec.Test do
  import Racket.Gateway.ByBit.Spec

  alias Racket.Gateway.Interface.Types.CurrencyPair

  use ExUnit.Case

  @moduletag :bybit

  doctest Racket.Gateway.ByBit.Spec

  describe "is_valid_leverage" do
    for { currency_pairs, max } <- [ { [CurrencyPair.BTCUSD], 100 },
                                     { [CurrencyPair.EOSUSD, CurrencyPair.ETHUSD, CurrencyPair.XRPUSD], 50 } ] do
      for currency_pair <- currency_pairs do
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
  end
end
