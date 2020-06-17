defmodule Racket.Gateway.Mixin do
  defmacro __using__(_opts) do
    quote do
      use Racket.Gateway.Interface

      def handle_response!({ _, %{status_code: status_code, body: body} }) do
        { status_code, body }
        |> validate_response!()
        |> Poison.decode!()
      end

      defp validate_response!({ 200, body }),      do: body
      defp validate_response!({ status_code, _ }), do: raise "#{status_code}: HTTP request failed"
    end
  end
end
