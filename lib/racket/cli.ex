defmodule Racket.CLI do

  #####################################################################################################################
  # PUBLIC
  #####################################################################################################################
  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
    OptionParser.parse(argv, switches: [ help: :boolean ], aliases: [ h: :help ])
    |> args_to_internal_representation
  end

  #####################################################################################################################
  # PRIVATE
  #####################################################################################################################
  defp args_to_internal_representation({ [], [], [] }) do
    nil
  end

  defp args_to_internal_representation({ [ help: true ], _, _ }) do
    :help
  end

  defp args_to_internal_representation(_) do
    :help
  end

  defp process(nil) do
    IO.puts("Spawning without arguments...")
  end

  defp process(:help) do
    IO.puts("Help!") #TODO: Provide a meaningful help context message
  end
end
