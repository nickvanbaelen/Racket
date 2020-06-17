defmodule Racket.Gateway.Interface.Private do
  defmacro __using__(_opts) do
    quote do
      @behaviour Racket.Gateway.Interface.Private
    end
  end

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
  @callback account_balance(String.t) :: map()
  # TODO: Make 'currency' a typed input parameter (using https://hex.pm/packages/enum_type?)
  #       Implementation of the enum should also be a behaviour (since different gateways
  #       can accept different input values)... Is this possbile?

  @doc """
  Returns the users account leverage settings for each currency pair
  """
  @callback account_leverage() :: map()

  @doc """
  Sets the users account leverage for the specified currency pair
  """
  @callback account_leverage(String.t, float()) :: map()

  @doc """
  Places a market order on the specified currency pair
  """
  @callback place_market_order(String.t, String.t, integer(), String.t) :: map()

  # TODO
  # @doc """
  # Places a limit order on the specified currency pair
  # """
  # @callback place_order_limit(String.t, String.t, integer(), integer(), String.t) :: map()
end
