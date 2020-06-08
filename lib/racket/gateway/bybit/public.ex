defmodule Racket.Gateway.ByBit.Public do
  import Racket.Gateway.ByBit
  import Racket.Utility.Time

  # INTERFACE IMPLEMENTATION
  use Racket.Mixin.Gateway.Public

  @impl Racket.Interface.Gateway.Public
  def url, do: base_url() <> "/v2/public"

  @impl Racket.Interface.Gateway.Public
  def timestamp do
    request("/time")
    |> Map.get("time_now")
    |> String.to_float
    |> to_milliseconds
    |> Kernel.trunc
  end
end
