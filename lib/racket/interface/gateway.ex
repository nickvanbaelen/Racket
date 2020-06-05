defmodule Racket.Interface.Gateway do
  @doc """
  Url pointing towards the server endpoint hosting the API
  """
  @callback base_api_url :: String.t
end
