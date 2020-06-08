defmodule Racket.Gateway.ByBit.Private do
  import Racket.Gateway.ByBit
  import Racket.Utility.Signing
  import Racket.Utility.Time

  # INTERFACE IMPLEMENTATION
  use Racket.Mixin.Gateway.Private

  @impl Racket.Interface.Gateway.Private
  def url, do: base_url() <> "/v2/private"

  #TODO: Use Config to retrieve this value (https://hexdocs.pm/elixir/Config.html#content)
  @impl Racket.Interface.Gateway.Private
  def api_key, do: "YCPQDTAXIJPAirXYYz"

  #TODO: Use Config to retrieve this value (https://hexdocs.pm/elixir/Config.html#content)
  @impl Racket.Interface.Gateway.Private
  def private_key, do: "QPm8L8jqZBQ1oLyDgz5bS20hVkFflsM4JQO4"

  @impl Racket.Interface.Gateway.Private
  def wallet_balance(coin) do
    request("/wallet/balance", %{coin: coin})
    |> Map.get("result")
    |> Map.get(coin)
  end
end
