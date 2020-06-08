defmodule Racket.Gateway.ByBit.Private do
  import Racket.Gateway.ByBit
  import Racket.Utility.Signing
  import Racket.Utility.Time

  # INTERFACE IMPLEMENTATION
  use Racket.Mixin.Gateway.Private

  @impl Racket.Interface.Gateway.Private
  def url, do: base_url() <> "/v2/private"

  #TODO: Get rid of boilerplate "url() |> HTTPoison.get(...) |> handle_response!" part
  @impl Racket.Interface.Gateway.Private
  def wallet_balance(coin) do
    url() <> "/wallet/balance"
    |> HTTPoison.get(["Content-Type": "application/json"],
                      params: sign("QPm8L8jqZBQ1oLyDgz5bS20hVkFflsM4JQO4", %{
                                                                              api_key: "YCPQDTAXIJPAirXYYz",
                                                                              coin: coin,
                                                                              timestamp: local_time()
                                                                            }))
    |> Racket.Gateway.ByBit.handle_response!
    |> decode_wallet_balance(coin)
  end

  # PRIVATE IMPLEMENTATIONS
  @spec decode_wallet_balance(map(), String.t) :: map()
  defp decode_wallet_balance(response, coin) do
    response["result"][coin]
  end
end
