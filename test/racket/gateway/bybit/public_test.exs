defmodule Racket.Gateway.ByBit.Public.Test do
  import Racket.Gateway.ByBit.Public

  use ExUnit.Case
  doctest Racket.Gateway.ByBit.Public

  test "timestamp" do
    import Racket.Utility.Time

    server_time = timestamp()
    local_time = local_time()

    assert Kernel.abs(server_time - local_time) < 1000
  end
end
