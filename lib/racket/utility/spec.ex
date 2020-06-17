defmodule Racket.Utility.Spec do
  use Spec

  @doc """
  Spec to test for a one element list

  ## Example

    iex> is_one_element_list?([1])
    true
    iex> is_one_element_list?([1,2])
    false
  """
  defspec is_one_element_list() do
    is_list() and &(Enum.count(&1) == 1)
  end
end
