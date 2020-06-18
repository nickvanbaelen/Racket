defmodule Racket.Gateway.Interface.Public do
  defmacro __using__(_opts) do
    quote do
      @behaviour Racket.Gateway.Interface.Public
    end
  end

  alias Racket.Gateway.Interface.Types.CurrencyPair

  @doc """
  Url pointing to the public part of the API
  """
  @callback url :: String.t

  @doc """
  Returns the ticker info for a specific currency pair
  """
  @callback ticker(CurrencyPair.t) :: map()
end
