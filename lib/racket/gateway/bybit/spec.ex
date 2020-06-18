defmodule Racket.Gateway.ByBit.Spec do
  import Racket.Utility.Math

  alias Racket.Gateway.Interface.Types.CurrencyPair

  use Spec

  #TODO: Specs should not be hardcoded, but should come dynamically from the ByBit API
  #      I.e. the list of valid symbols should be parsed by analysing the result of querying
  #           API endpoint /v2/public/symbols, etc...

  defspec is_valid_leverage(currency_pair) do
    &(case currency_pair do
        CurrencyPair.BTCUSD ->
          &1 == 0 or (1 <= &1 and &1 <= 100 and &1 |> is_divisble_by(0.01))
        CurrencyPair.ETHUSD ->
          &1 == 0 or (1 <= &1 and &1 <=  50 and &1 |> is_divisble_by(0.01))
        CurrencyPair.EOSUSD ->
          &1 == 0 or (1 <= &1 and &1 <=  50 and &1 |> is_divisble_by(0.01))
        CurrencyPair.XRPUSD ->
          &1 == 0 or (1 <= &1 and &1 <=  50 and &1 |> is_divisble_by(0.01))
        _ ->
          false
      end)
  end
end
