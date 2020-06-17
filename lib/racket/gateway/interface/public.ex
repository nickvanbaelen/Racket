defmodule Racket.Gateway.Interface.Public do
  defmacro __using__(_opts) do
    quote do
      @behaviour Racket.Gateway.Interface.Public
    end
  end

  @doc """
  Url pointing to the public part of the API
  """
  @callback url :: String.t

  #TODO: Remove this from the interface, move to ByBit private gateway implementation
  @doc """
  Returns the server time in milliseconds
  """
  @callback timestamp :: integer

  @doc """
  Returns the ticker info for a specific currency pair
  """
  @callback ticker(String.t) :: map()
end
