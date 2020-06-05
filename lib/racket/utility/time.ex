defmodule Racket.Utility.Time do

  @spec local_time() :: integer()
  def local_time, do: :os.system_time(:millisecond)

  @spec to_milliseconds(number()) :: number()
  def to_milliseconds(seconds), do: seconds * 1000

end
