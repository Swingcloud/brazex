defmodule Brazex.MixProject do
  use Mix.Project

  def project do
    [
      app: :brazex,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      elixirc_options: elixirc_options(Mix.env()),
      aliases: aliases(),
      dialyzer: [
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"},
        ignore_warnings: ".dialyzer_ignore.exs"
      ],
      preferred_cli_env: [
        quality: :test,
        "quality.ci": :test
      ],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_options(:prod),
    do: [
      warnings_as_errors: true
    ]

  defp elixirc_options(_), do: []

  defp aliases do
    [
      quality: ["format", "credo --strict", "dialyzer", "test"],
      "quality.ci": [
        "format --check-formatted",
        "credo --strict",
        "dialyzer --halt-exit-status",
        "test"
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.1", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.7", only: [:dev, :test], runtime: false}
    ]
  end
end
