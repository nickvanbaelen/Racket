defmodule Racket.Utility.Math do
  @doc """
  Return whether a number is approximately divisible by a divisor, given a tolerance of epsilon

  ## Examples

    iex> is_divisble_by(9, 3)
    true
    iex> is_divisble_by(0.1, 0.01)
    true
    iex> is_divisble_by(1, 0.05)
    true
    iex> is_divisble_by(32, 9)
    false
    iex> is_divisble_by(2.1, 0.8)
    false
  """
  @spec is_divisble_by(number(), number(), float()) :: boolean()
  def is_divisble_by(number, divisor, epsilon \\ 1.0e-10) do
    abs(number - round(number / divisor) * divisor) <= epsilon
  end
end


