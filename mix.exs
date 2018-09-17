defmodule PodRss.MixProject do
  use Mix.Project

  def project do
    [
      app: :pod_rss,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      #{:SweetXml, "~> 0.6.5"},
      {:sweet_xml, git: "https://github.com/kbrw/sweet_xml"},
      {:httpoison, "~> 1.3.0"}
    ]
  end
end
