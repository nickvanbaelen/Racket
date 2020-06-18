defmodule Racket.Gateway.ByBit.Test do
  use ExUnit.Case

  doctest Racket.Gateway.ByBit

  describe "Config" do
    test "api_key" do
      assert Application.fetch_env!(:racket, :bybit)[:api_key] == "YCPQDTAXIJPAirXYYz"
    end

    test "private_key" do
      assert Application.fetch_env!(:racket, :bybit)[:private_key] == "QPm8L8jqZBQ1oLyDgz5bS20hVkFflsM4JQO4"
    end
  end
end
