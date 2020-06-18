defmodule Racket.Gateway.Interface.Types do
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

  defenum OrderExpiration do
    value GOOD_TILL_CANCEL, "GoodTillCancel"
    value IMMEDIATE_OR_CANCEL, "ImmediateOrCancel"
    value FILL_OR_KILL, "FillOrKill"
    value POST_ONLY, "PostOnly"
  end
end
