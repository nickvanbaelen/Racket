defmodule Racket.Gateway.ByBit.Private do
  import Racket.Gateway.ByBit
  import Racket.Utility.Signing
  import Racket.Utility.Time

  # INTERFACE IMPLEMENTATION
  use Racket.Mixin.Gateway.Private

  @impl Racket.Interface.Gateway.Private
  def url, do: base_url()

  #TODO: Use Config to retrieve this value (https://hexdocs.pm/elixir/Config.html#content)
  @impl Racket.Interface.Gateway.Private
  def api_key, do: "YCPQDTAXIJPAirXYYz"

  #TODO: Use Config to retrieve this value (https://hexdocs.pm/elixir/Config.html#content)
  @impl Racket.Interface.Gateway.Private
  def private_key, do: "QPm8L8jqZBQ1oLyDgz5bS20hVkFflsM4JQO4"

  @impl Racket.Interface.Gateway.Private
  def account_balance(currency) do
    request("/v2/private/wallet/balance", %{coin: currency})
    |> Map.get("result")
    |> Map.get(currency)
  end

  @impl Racket.Interface.Gateway.Private
  def account_leverage do
    request("/user/leverage")
    |> Map.get("result")
  end

  @impl Racket.Interface.Gateway.Private
  def account_leverage(symbol, amount) do
    submit("/user/leverage/save", %{
                                     symbol: symbol,
                                     leverage: amount
                                   })
    |> Map.get("result")
  end

  @impl Racket.Interface.Gateway.Private
  def place_market_order(side, symbol, amount, timespan) do
    submit("/v2/private/order/create", %{
                                          side: side,
                                          symbol: symbol,
                                          order_type: "Market",
                                          qty: amount,
                                          time_in_force: timespan
                                        })
    |> Map.get("result")
  end

end
