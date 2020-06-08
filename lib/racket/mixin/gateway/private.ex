defmodule Racket.Mixin.Gateway.Private do
  defmacro __using__(_opts) do
    quote do
      use Racket.Interface.Gateway.Private
    end
  end
end
