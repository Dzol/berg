defmodule Heap.Mixfile do
  use Mix.Project

  def project do
    [app: :heapex,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     docs: documentation()]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [{:heap, path: "./erlang"},
     {:dialyxir, "~> 0.4", only: [:dev], runtime: false},
     {:ex_doc, "~> 0.15", only: :dev, runtime: false}
    ]
  end

  defp documentation do
    [output: "docs"]
  end
end
