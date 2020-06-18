defmodule Racket.Gateway.Interface.Private do
  defmacro __using__(_opts) do
    quote do
      @behaviour Racket.Gateway.Interface.Private
    end
  end

  #TODO: What if the gateway implementing a specific behaviour doesn't support one of the
  #      values defined in a specific EnumType (for example CurrencyPair.EOSUSD) ???
  #
  #        - A behavior implementation can be fspec'ed to apply an extra 'validity' check
  #          on the provided input parameter; do not handle the request if the input parameter
  #          isn't valid
  #
  #        - ...

  #TODO: Define custom return types instead of expecting a generic map, this will completely settle
  #      the interface the implementations should adhere to. An implementation is expected to encode
  #      its result to the defined output type, regardless of the type of reply they receive from the
  #      API endpoint.
  #
  #      https://elixir-lang.org/getting-started/typespecs-and-behaviours.html#defining-custom-types

  alias Racket.Gateway.Interface.Types.Currency
  alias Racket.Gateway.Interface.Types.CurrencyPair
  alias Racket.Gateway.Interface.Types.OrderExpiration
  alias Racket.Gateway.Interface.Types.OrderSide

  @doc """
  Url pointing to the private part of the API
  """
  @callback url :: String.t

  @doc """
  API key defining the private endpoint to send the requests to
  """
  @callback api_key :: String.t

  @doc """
  Private key used to sign messages in order to authenticate to the private endpoint
  """
  @callback private_key :: String.t

  @doc """
  Returns the users account balance for the specified currency
  """
  @callback account_balance(Currency.t()) :: map()

  @doc """
  Returns the users account leverage settings for each currency pair
  """
  @callback account_leverage() :: map()

  @doc """
  Sets the users account leverage for the specified currency pair
  """
  @callback account_leverage(CurrencyPair.t(), float()) :: map()

  @doc """
  Places a market order on the specified currency pair
  """
  @callback place_market_order(OrderSide.t(), CurrencyPair.t(), integer(), OrderExpiration.t) :: map()

  # TODO
  # @doc """
  # Places a limit order on the specified currency pair
  # """
  # @callback place_order_limit(OrderSide.t(), CurrencyPair.t, integer(), integer(), String.t) :: map()
end
