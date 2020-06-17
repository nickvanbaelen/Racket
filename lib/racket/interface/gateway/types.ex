defmodule Racket.Interface.Gateway.Types do
  use EnumType

  defenum Currency do
    value BTC,  "BTC"
    value EOS,  "EOS"
    value ETH,  "ETH"
    value XRP,  "XRP"
    value USDT, "USDT"
  end

  defenum CurrencyPair do
    value BTCUSD, "BTCUSD"
    value EOSUSD, "EOSUSD"
    value ETHUSD, "ETHUSD"
    value XRPUSD, "XRPUSD"
  end

  defenum OrderSide do
    value BUY, "Buy"
    value SELL, "Sell"
  end

  defenum OrderType do
    value LIMIT, "Limit"
    value MARKET, "Market"
  end
end
