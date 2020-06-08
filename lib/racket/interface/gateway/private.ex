defmodule Racket.Interface.Gateway.Private do
  defmacro __using__(_opts) do
    quote do
      @behaviour Racket.Interface.Gateway.Private
    end
  end

  @doc """
  Url pointing to the private part of the API
  """
  @callback url :: String.t

  @doc """
  Returns the users wallet balance
  """
  @callback wallet_balance(String.t) :: map()
end
