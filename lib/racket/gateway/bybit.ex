defmodule Racket.Gateway.ByBit do
  @behaviour Racket.Interface.Gateway
  @behaviour Racket.Interface.Gateway.Public # TODO: Can this be reduced to simply:
                                             #           use Racket.Interface.Gateway.Public
                                             #       Racket.Interface.Gateway.Public would in turn have it's own
                                             #           use Racket.Interface.Gateway
                                             #       Which would scope in the required function definitions and
                                             #       behaviors that need to be defined
                                             #       ???
  @behaviour Racket.Interface.Gateway.Private

  #####################################################################################################################
  # IMPORTS
  #####################################################################################################################
  import Racket.Mixin.Gateway
  import Racket.Utility.Signing
  import Racket.Utility.Time

  #####################################################################################################################
  # API
  #####################################################################################################################
  #TODO: Configure this as a Config variable
  @impl Racket.Interface.Gateway
  def base_api_url, do: "https://api-testnet.bybit.com"

  @impl Racket.Interface.Gateway.Public
  def public_api_url, do: base_api_url() <> "/v2/public"

  #TODO: Get rid of boilerplate "public_api_url() |> HTTPoison.get() |> handle_response!" part
  @impl Racket.Interface.Gateway.Public
  def timestamp do
    public_api_url() <> "/time"
    |> HTTPoison.get()
    |> handle_response!
    |> decode_timestamp
  end

  @impl Racket.Interface.Gateway.Private
  def private_api_url, do: base_api_url() <> "/v2/private"

  #TODO: Get rid of boilerplate "private_api_url() |> HTTPoison.get(...) |> handle_response!" part
  @impl Racket.Interface.Gateway.Private
  def wallet_balance(coin) do
    private_api_url() <> "/wallet/balance"
    |> HTTPoison.get(["Content-Type": "application/json"],
                     params: sign("QPm8L8jqZBQ1oLyDgz5bS20hVkFflsM4JQO4", %{
                                                                             api_key: "YCPQDTAXIJPAirXYYz",
                                                                             coin: coin,
                                                                             timestamp: local_time()
                                                                           }))
    |> handle_response!
    |> decode_wallet_balance(coin)
  end

  #####################################################################################################################
  # PRIVATE
  #####################################################################################################################
  @spec decode_timestamp(map()) :: integer()
  defp decode_timestamp(response) do
    response["time_now"]
    |> String.to_float
    |> to_milliseconds
    |> Kernel.trunc
  end

  @spec decode_wallet_balance(map(), String.t) :: map()
  defp decode_wallet_balance(response, coin) do
    response["result"][coin]
  end
end
