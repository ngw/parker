defmodule Parker.Mixfile do
  use Mix.Project

  def project do
    [app: :parker,
     version: "0.1.0",
     elixir: "~> 1.5",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     elixirc_paths: elixirc_paths(Mix.env)]
  end

  def application do
    [extra_applications: [:logger, :hackney]]
  end

  defp deps do
    [
      {:gen_stage,                "~> 0.11"},
      {:httpipe_adapters_hackney, "~> 0.9"},
      {:httpipe,                  "~> 0.9"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
