defmodule Racket.Gateway.ByBit.Public do
  import Racket.Gateway.ByBit
  import Racket.Utility.Time

  # INTERFACE IMPLEMENTATION
  use Racket.Mixin.Gateway.Public

  @impl Racket.Interface.Gateway.Public
  def url, do: base_url() <> "/v2/public"

  #TODO: Get rid of boilerplate "url() |> HTTPoison.get() |> handle_response!" part
  @impl Racket.Interface.Gateway.Public
  def timestamp do
    url() <> "/time"
    |> HTTPoison.get()
    |> Racket.Gateway.ByBit.handle_response!
    |> decode_timestamp
  end

  # PRIVATE IMPLEMENTATIONS
  @spec decode_timestamp(map()) :: integer()
  defp decode_timestamp(response) do
    response["time_now"]
    |> String.to_float
    |> to_milliseconds
    |> Kernel.trunc
  end
end
