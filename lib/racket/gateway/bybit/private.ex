defmodule Racket.Gateway.ByBit.Private do
  import Racket.Gateway.ByBit
  import Racket.Gateway.ByBit.Spec
  import Racket.Utility.Signing
  import Racket.Utility.Time

  alias Racket.Gateway.Interface.Types.OrderType

  # INTERFACE IMPLEMENTATION
  use Racket.Gateway.Mixin.Private

  @impl Racket.Gateway.Interface.Private
  def url, do: base_url()

  @impl Racket.Gateway.Interface.Private
  def api_key, do: Application.fetch_env!(:racket, :bybit)[:api_key]

  @impl Racket.Gateway.Interface.Private
  def private_key, do: Application.fetch_env!(:racket, :bybit)[:private_key]

  @impl Racket.Gateway.Interface.Private
  def account_balance(currency) do
    request("/v2/private/wallet/balance", %{coin: currency.value()})
    |> Map.get("result")
    |> Map.get(currency.value())
  end

  @impl Racket.Gateway.Interface.Private
  def account_leverage do
    request("/user/leverage")
    |> Map.get("result")
  end

  #TODO: Use fspec instead of validating parameters in function code
  @impl Racket.Gateway.Interface.Private
  def account_leverage(currency_pair, amount) do
    submit("/user/leverage/save", %{
                                     symbol: currency_pair.value(),
                                     leverage: is_valid_leverage!(amount, currency_pair)
                                   })
    |> Map.get("result")
  end

  @impl Racket.Gateway.Interface.Private
  def place_market_order(side, currency_pair, amount, expiration) do
    submit("/v2/private/order/create", %{
                                          side: side.value(),
                                          symbol: currency_pair.value(),
                                          order_type: OrderType.MARKET.value(),
                                          qty: amount,
                                          time_in_force: expiration.value()
                                        })
    |> decode_market_order()
  end

  # PRIVATE IMPLEMENTATION
  @spec decode_market_order(map()) :: map()
  defp decode_market_order(reply = %{ "ret_code" => 0 }), do: { :ok,    Map.get(reply, "result")   }
  defp decode_market_order(reply)                       , do: { :error, Map.get(reply, "ret_code") }
end
