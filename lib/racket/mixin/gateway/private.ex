defmodule Racket.Mixin.Gateway.Private do
  defmacro __using__(_opts) do
    quote do
      use Racket.Interface.Gateway.Private

      @spec request(String.t, map()) :: map()
      defp request(endpoint, params) do
        url() <> endpoint
        |> HTTPoison.get(["Content-Type": "application/json"],
                         params: sign(private_key(), Map.merge(params, %{
                                                                          api_key: api_key(),
                                                                          timestamp: local_time()
                                                                        })))
        |> handle_response!
      end
    end
  end
end
