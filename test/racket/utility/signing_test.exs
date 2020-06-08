defmodule Racket.Utility.Signing.Test do
  import Racket.Utility.Signing

  use ExUnit.Case
  doctest Racket.Utility.Signing

  def bybit_example_key do
    "QPm8L8jqZBQ1oLyDgz5bS20hVkFflsM4JQO4"
  end

  def bybit_example_headers do
    %{
      coin: "BTC",
      api_key: "YCPQDTAXIJPAirXYYz",
      recv_window: 120000,
      timestamp: 1591452328856
    }
  end

  test "payload" do
    assert payload(bybit_example_headers()) == "api_key=YCPQDTAXIJPAirXYYz&coin=BTC&recv_window=120000&timestamp=1591452328856"
  end

  test "hmac_sha256" do
    assert hmac_sha256(bybit_example_key(), payload(bybit_example_headers())) == "E89A796D28E349EAAC7DE2676683EB26AC269DB1F38F08DA5B5AA2BE5520B895"
  end

  test "sign" do
    headers = bybit_example_headers()
    signed_headers = sign(bybit_example_key(), headers)

    assert signed_headers[:api_key]     == headers[:api_key]
    assert signed_headers[:coin]        == headers[:coin]
    assert signed_headers[:recv_window] == headers[:recv_window]
    assert signed_headers[:timestamp]   == headers[:timestamp]
    assert signed_headers[:sign]        == "E89A796D28E349EAAC7DE2676683EB26AC269DB1F38F08DA5B5AA2BE5520B895"
  end

end
