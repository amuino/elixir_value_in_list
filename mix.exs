defmodule ValueInList.MixProject do
  use Mix.Project

  def project do
    [
      app: :value_in_list,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:benchee, "~> 1.0", only: [:dev, :test]}
    ]
  end

  defp aliases do
    [
      bench: "run -e ValueInList.bench"
    ]
  end
end
