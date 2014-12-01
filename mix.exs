defmodule ElixirExample.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_example,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: ["lib", "web"],
     compilers: [:phoenix] ++ Mix.compilers,
     deps: deps,
     escript: [main_module: Eg.Benchmark]]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {ElixirExample, []},
     applications: [:phoenix, :cowboy, :logger, :example_application]]
  end

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix, "0.5.0"},
     {:cowboy, "~> 1.0", },
     {:cowlib, "~> 1.0.0", [override: true, optional: false, hex: :cowlib]},
     {:ranch, "~> 1.0.0",  [override: true, optional: false, hex: :ranch]},
     {:example_application, path: "example_application"},
     { :uuid, "~> 0.1.5" },
     {:poison, "1.2.0"}
     ]
  end
end
