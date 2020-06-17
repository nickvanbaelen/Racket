defmodule Racket.Gateway.Interface do
  defmacro __using__(_opts) do
    quote do
      @behaviour Racket.Gateway.Interface
    end
  end

  @doc """
  Url pointing towards the server endpoint hosting the API
  """
  @callback base_url :: String.t
end
