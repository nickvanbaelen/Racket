defmodule Racket.Gateway.ByBit do
  # INTERFACE IMPLEMENTATION
  use Racket.Gateway.Mixin

  @impl Racket.Gateway.Interface
  def base_url, do: "https://api-testnet.bybit.com"
end
