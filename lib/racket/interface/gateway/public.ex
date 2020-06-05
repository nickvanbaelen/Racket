defmodule Racket.Interface.Gateway.Public do
  @doc """
  Url pointing to the public part of the API
  """
  @callback public_api_url :: String.t

  @doc """
  Returns the server time in milliseconds
  """
  @callback timestamp :: integer
end
