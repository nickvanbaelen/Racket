defmodule Racket.Interface.Gateway.Private do
  @doc """
  Url pointing to the private part of the API
  """
  @callback private_api_url :: String.t

  @doc """
  Returns the users wallet balance
  """
  @callback wallet_balance(String.t) :: map()
end
