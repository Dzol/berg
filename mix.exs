defmodule Berg.Mixfile do
  use Mix.Project

  def project do
    [name: "Berg",
     app: :berg,
     version: "1.0.0",
     description: description(),
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     aliases: aliases(),
     test_pattern: "*_{test,property}.exs",
     docs: documentation(),
     package: package()
    ] ++ erlang() ++ dialyzer()
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [{:propcheck, "~> 0.0.1"},
     {:dialyxir, "~> 0.4", only: [:dev], runtime: false},
     {:credo, "~> 0.5", only: [:dev, :test]},
     {:ex_doc, "~> 0.15", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    Berg is a Minimum Heap just for Integers
    """
  end

  defp aliases do
    [property: [&test/1, "test property/"],
     docs: ["docs", &picture/1]]
  end

  defp test(_) do
    Mix.env(:test)
  end

  defp documentation do
    [output: "docs",
     main: "Berg"
    ]
  end

  defp package do
    [licenses: "GNU GPLv3",
     maintainers: ["Joseph Yiasemides"],
     files: ["erlang", "lib", "mix.exs", "README.md", "LICENSE.txt"],
     links: %{"GitHub" => "https://github.com/Dzol/berg/",
              "Docs" => "https://dzol.github.io/berg/"
             }
    ]
  end

  defp erlang do
    [erlc_paths: ["erlang"]
    ]
  end

  defp dialyzer do
    [dialyzer: [plt_core_path: ".dialyzer/"]
    ]
  end

  defp picture(_) do
    File.cp("./tatra.jpg", "./docs/tatra.jpg")
  end
end
