defmodule Racket.Gateway.ByBit.Public.Test do
  import Racket.Gateway.ByBit.Public

  alias Racket.Gateway.Interface.Types.CurrencyPair

  use ExUnit.Case

  @moduletag :bybit

  doctest Racket.Gateway.ByBit.Public

  describe "available_currency_pairs" do
    for currency_pair <- Enum.reduce(available_currency_pairs(), [], fn x, acc -> [Map.get(x, "name") | acc] end) do
      test "#{currency_pair}" do
        CurrencyPair.from(unquote(currency_pair))
      end
    end
  end

  describe "ticker" do
    @describetag :api
    for currency_pair <- CurrencyPair.enums() do
      test "#{currency_pair}" do
        assert Map.get(ticker(unquote(currency_pair)), "symbol") == unquote(currency_pair.value())
      end
    end
  end
end
