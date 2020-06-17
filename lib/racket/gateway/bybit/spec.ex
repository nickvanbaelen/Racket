defmodule Racket.Gateway.ByBit.Spec do
  import Racket.Utility.Math

  alias Racket.Gateway.Interface.Types.Currency
  alias Racket.Gateway.Interface.Types.CurrencyPair
  alias Racket.Gateway.Interface.Types.OrderSide
  alias Racket.Gateway.Interface.Types.OrderType

  use Spec

  #TODO: These specs should not be hardcoded, but should come dynamically from the ByBit API
  #      I.e. the list of valid symbols should be parsed by analysing the result of querying
  #           API endpoint /v2/public/symbols, etc...

  defspec is_valid_currency() do
    &(Enum.member?(Currency.values(), &1))
  end

  defspec is_valid_currency_pair() do
    &(Enum.member?(CurrencyPair.values(), &1))
  end

  defspec is_valid_leverage(currency_pair) do
    &(case currency_pair do
        "BTCUSD" -> &1 == 0 or (1 <= &1 and &1 <= 100 and &1 |> is_divisble_by(0.01))
        "ETHUSD" -> &1 == 0 or (1 <= &1 and &1 <=  50 and &1 |> is_divisble_by(0.01))
        "EOSUSD" -> &1 == 0 or (1 <= &1 and &1 <=  50 and &1 |> is_divisble_by(0.01))
        "XRPUSD" -> &1 == 0 or (1 <= &1 and &1 <=  50 and &1 |> is_divisble_by(0.01))
        _ -> false
      end)
  end

  defspec is_valid_order_side() do
    &(Enum.member?(OrderSide.values(), &1))
  end

  defspec is_valid_order_type() do
    &(Enum.member?(OrderType.values(), &1))
  end
end
