defmodule Shopify.OAuth.MixProject do
  use Mix.Project

  def project do
    [
      app: :shopify_oauth,
      version: "1.0.1",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: dialyzer(),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      { :hackney, "~> 1.15", optional: true },
      { :jason, "~> 1.1", optional: true },

      #
      # dev
      #

      { :dialyxir, "~> 1.0-rc", only: :dev, runtime: false },
      { :ex_doc, ">= 0.0.0", only: :dev, runtime: false },

      #
      # test
      #

      { :bypass, "~> 1.0", only: :test }
    ]
  end

  defp dialyzer do
    [
      plt_add_apps: [:hackney],
      plt_core_path: "./_build/#{Mix.env()}"
    ]
  end

  defp package do
    %{
      description: "Elixir client for the Shopify OAuth API",
      maintainers: ["Anthony Smith"],
      licenses: ["MIT"],
      links: %{
        GitHub: "https://github.com/malomohq/shopify-oauth-elixir",
        "Made by Malomo - Post-purchase experiences that customers love": "https://gomalomo.com"
      }
    }
  end
end
