defmodule Parker.Mixfile do
  use Mix.Project

  def project do
    [app: :parker,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger, :hackney]]
  end

  defp deps do
    [
      {:httpipe_adapters_hackney, "~> 0.9"},
      {:httpipe,                  "~> 0.9"}
    ]
  end
end
