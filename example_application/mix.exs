defmodule ExampleApplication.Mixfile do
  use Mix.Project

  def project do
    [app: :example_application,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  # Configuration for the OTP application
#
  #
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :httpoison, :recon],
  
    # defining enviormental variable to be used within the erlang VM
    
     env: [output_external_host: 'localhost', # elixir gotcha -> "" is binary , '' is list
           output_external_port: 9292,
           ],
     # Use EgApplication as the 'Application' module
     mod: {EgApplication, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
    {:httpoison, "~> 0.5"},
    {:mock, git: "https://github.com/jjh42/mock"},
    {:poison, "1.2.0"},
    {:recon, "2.2.0"}
    ]
  end
end
