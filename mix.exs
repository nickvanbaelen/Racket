defmodule Racket.MixProject do
  use Mix.Project

  def project do
    [
      app: :racket,
      escript: escript_config(),
      version: "0.0.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Racket.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.6"},
      {:poison, "~> 4.0"}
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  # Packaging using escript using "mix escript.build"
  # Run the packaged executable by using "escript racket"
  defp escript_config do
    [
      main_module: Racket.CLI
    ]
  end
end
