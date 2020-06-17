defmodule Racket.Gateway.ByBit.Public do
  import Racket.Gateway.ByBit
  import Racket.Gateway.ByBit.Spec
  import Racket.Utility.Time
  import Racket.Utility.Spec

  # INTERFACE IMPLEMENTATION
  use Racket.Gateway.Mixin.Public

  @impl Racket.Gateway.Interface.Public
  def url, do: base_url() <> "/v2/public"

  @impl Racket.Gateway.Interface.Public
  def timestamp do
    request("/time")
    |> Map.get("time_now")
    |> String.to_float
    |> to_milliseconds
    |> Kernel.trunc
  end

  @impl Racket.Gateway.Interface.Public
  def ticker(currency_pair) do
    request("/tickers", %{ symbol: is_valid_currency_pair!(currency_pair) })
    |> Map.get("result")
    |> is_one_element_list!()
    |> Enum.at(0)
  end
end
