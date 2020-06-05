defmodule Racket.Utility.Time.Test do
  use ExUnit.Case
  doctest Racket.Utility.Time

  import  Racket.Utility.Time

  test "Convert seconds to milliseconds" do
    assert 1000   == to_milliseconds(1)
    assert 1234   == to_milliseconds(1.234)
    assert 1234.5 == to_milliseconds(1.2345)
  end

  test "Local time" do
    t1 = local_time()
    Process.sleep(50);
    t2 = local_time()

    assert t1 < t2
  end
end
