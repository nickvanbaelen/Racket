defmodule Racket.Gateway.ByBit.Test do
  use ExUnit.Case
  doctest Racket.Gateway.ByBit

  import Racket.Gateway.ByBit
  import Racket.Utility.Time

  describe "Public" do
    test "timestamp" do
      server_time = timestamp()
      local_time = local_time()

      assert Kernel.abs(server_time - local_time) < 1000
    end
  end

  describe "Private" do
    test "wallet_balance" do
      IO.inspect(wallet_balance("BTC"))
    end
  end
end
