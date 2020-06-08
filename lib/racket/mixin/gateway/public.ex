defmodule Racket.Mixin.Gateway.Public do
  defmacro __using__(_opts) do
    quote do
      use Racket.Interface.Gateway.Public
    end
  end
end
