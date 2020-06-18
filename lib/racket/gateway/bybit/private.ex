defmodule Racket.Gateway.ByBit.Private do
  import Racket.Gateway.ByBit
  import Racket.Gateway.ByBit.Spec
  import Racket.Utility.Signing
  import Racket.Utility.Time

  alias Racket.Gateway.Interface.Types.OrderType

  # INTERFACE IMPLEMENTATION
  use Racket.Gateway.Mixin.Private

  @impl Racket.Gateway.Interface.Private
  def url, do: base_url()

  #TODO: Use Config to retrieve this value (https://hexdocs.pm/elixir/Config.html#content)
  @impl Racket.Gateway.Interface.Private
  def api_key, do: "YCPQDTAXIJPAirXYYz"

  #TODO: Use Config to retrieve this value (https://hexdocs.pm/elixir/Config.html#content)
  @impl Racket.Gateway.Interface.Private
  def private_key, do: "QPm8L8jqZBQ1oLyDgz5bS20hVkFflsM4JQO4"

  @impl Racket.Gateway.Interface.Private
  def account_balance(currency) do
    request("/v2/private/wallet/balance", %{coin: currency.value()})
    |> Map.get("result")
    |> Map.get(currency.value())
  end

  @impl Racket.Gateway.Interface.Private
  def account_leverage do
    request("/user/leverage")
    |> Map.get("result")
  end

  #TODO: Use fspec instead of validating parameters in function code
  @impl Racket.Gateway.Interface.Private
  def account_leverage(currency_pair, amount) do
    submit("/user/leverage/save", %{
                                     symbol: currency_pair.value(),
                                     leverage: is_valid_leverage!(amount, currency_pair)
                                   })
    |> Map.get("result")
  end

  @impl Racket.Gateway.Interface.Private
  def place_market_order(side, currency_pair, amount, expiration) do
    submit("/v2/private/order/create", %{
                                          side: side.value(),
                                          symbol: currency_pair.value(),
                                          order_type: OrderType.MARKET.value(),
                                          qty: amount,
                                          time_in_force: expiration.value()
                                        })
    |> Map.get("result")
  end

end
