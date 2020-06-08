defmodule Racket.Mixin.Gateway.Public do
  defmacro __using__(_opts) do
    quote do
      use Racket.Interface.Gateway.Public

      @spec request(String.t) :: map()
      defp request(endpoint) do
        url() <> endpoint
        |> HTTPoison.get()
        |> handle_response!
      end
    end
  end
end
