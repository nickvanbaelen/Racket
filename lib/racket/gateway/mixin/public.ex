defmodule Racket.Gateway.Mixin.Public do
  defmacro __using__(_opts) do
    quote do
      use Racket.Gateway.Interface.Public

      @spec request(String.t) :: map()
      defp request(endpoint) do
        url() <> endpoint
        |> HTTPoison.get()
        |> handle_response!
      end

      @spec request(String.t, map()) :: map()
      defp request(endpoint, params) do
        url() <> endpoint
        |> HTTPoison.get(["Content-Type": "application/json"], params: params)
        |> handle_response!
      end
    end
  end
end
