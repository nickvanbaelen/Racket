defmodule Racket.Gateway.ByBit do
  # INTERFACE IMPLEMENTATION
  use Racket.Mixin.Gateway

  @impl Racket.Interface.Gateway
  def base_url, do: "https://api-testnet.bybit.com"
end
