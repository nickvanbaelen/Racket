defmodule Racket.Gateway.ByBit do
  @behaviour Racket.Interface.Gateway
  @behaviour Racket.Interface.Gateway.Public # TODO: Can this be reduced to simply:
                                             #           use Racket.Interface.Gateway.Public
                                             #       Racket.Interface.Gateway.Public would in turn have it's own
                                             #           use Racket.Interface.Gateway
                                             #       Which would scope in the required function definitions and
                                             #       behaviors that need to be defined
                                             #       ???

  #####################################################################################################################
  # IMPORTS
  #####################################################################################################################
  import Racket.Mixin.Gateway
  import Racket.Utility.Time

  #####################################################################################################################
  # API
  #####################################################################################################################

  @impl Racket.Interface.Gateway
  def base_api_url, do: "https://api-testnet.bybit.com" # TODO: Configure this as a Config variable

  @impl Racket.Interface.Gateway.Public
  def public_api_url, do: base_api_url() <> "/v2/public"

  @impl Racket.Interface.Gateway.Public
  def timestamp do
    public_api_url() <> "/time"
    |> HTTPoison.get()
    |> handle_response!
    |> decode_timestamp
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
end
