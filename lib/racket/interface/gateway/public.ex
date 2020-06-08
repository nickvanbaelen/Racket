defmodule Racket.Interface.Gateway.Public do
  defmacro __using__(_opts) do
    quote do
      @behaviour Racket.Interface.Gateway.Public
    end
  end

  @doc """
  Url pointing to the public part of the API
  """
  @callback url :: String.t

  @doc """
  Returns the server time in milliseconds
  """
  @callback timestamp :: integer
end
