defmodule Racket.Interface.Gateway do
  defmacro __using__(_opts) do
    quote do
      @behaviour Racket.Interface.Gateway
    end
  end

  @doc """
  Url pointing towards the server endpoint hosting the API
  """
  @callback base_url :: String.t
end
