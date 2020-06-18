defmodule Racket.Gateway.ByBit.Public.Test do
  import Racket.Gateway.ByBit.Public

  alias Racket.Gateway.Interface.Types.CurrencyPair

  use ExUnit.Case

  @moduletag :bybit

  doctest Racket.Gateway.ByBit.Public

  @tag :api
  test "timestamp" do
    import Racket.Utility.Time

    server_time = timestamp()
    local_time = local_time()

    assert Kernel.abs(server_time - local_time) < 2000
  end

  describe "ticker" do
    @describetag :api
    for currency_pair <- CurrencyPair.values() do
      test "#{currency_pair}" do
        assert Map.get(ticker(unquote(currency_pair)), "symbol") == unquote(currency_pair)
      end
    end
  end
end
