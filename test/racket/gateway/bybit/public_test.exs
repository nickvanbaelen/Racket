defmodule Racket.Gateway.ByBit.Public.Test do
  import Racket.Gateway.ByBit.Public

  alias Racket.Gateway.Interface.Types.CurrencyPair

  use ExUnit.Case

  @moduletag :bybit

  doctest Racket.Gateway.ByBit.Public

  describe "ticker" do
    @describetag :api
    for currency_pair <- CurrencyPair.enums() do
      test "#{currency_pair}" do
        assert Map.get(ticker(unquote(currency_pair)), "symbol") == unquote(currency_pair.value())
      end
    end
  end
end
