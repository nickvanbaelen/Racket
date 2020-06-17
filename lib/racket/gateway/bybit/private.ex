defmodule Racket.Gateway.ByBit.Private do
  import Racket.Gateway.ByBit
  import Racket.Gateway.ByBit.Spec
  import Racket.Utility.Signing
  import Racket.Utility.Time

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
    request("/v2/private/wallet/balance", %{coin: is_valid_currency!(currency)})
    |> Map.get("result")
    |> Map.get(currency)
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
                                     symbol: is_valid_currency_pair!(currency_pair),
                                     leverage: is_valid_leverage!(amount, currency_pair)
                                   })
    |> Map.get("result")
  end

  @impl Racket.Gateway.Interface.Private
  def place_market_order(side, currency_pair, amount, timespan) do
    submit("/v2/private/order/create", %{
                                          side: is_valid_order_side!(side),
                                          symbol: is_valid_currency_pair!(currency_pair),
                                          order_type: is_valid_order_type!("Market"),
                                          qty: amount,
                                          time_in_force: timespan
                                        })
    |> Map.get("result")
  end

end
