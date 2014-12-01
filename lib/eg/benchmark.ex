defmodule Eg.Benchmark do
  use Mix.Task
  require Logger
  alias Poison, as: JSON 
  def main(args) do
    [run_count| tail] = args

    ElixirExample.Router.start
    # reset counter
    {real_total_run_time, real_time_since_last_call} = :erlang.statistics(:wall_clock)
    #
    # Internall the BenchmarkServer is recording a Run time for it's deepest succeful 
    # code path
    #
    # This is effectively used to find the time to process an average request
    execute_n_requests(String.to_integer(run_count))
    IO.puts "Total Internal Clock:"
    IO.puts(inspect(Example.BenchmarkServer.total_clock(Example.BenchmarkServer)) <> " ms" )
    IO.puts "Average Internal Cost Per Call:"
    IO.puts(inspect(Example.BenchmarkServer.average_cost_per_call(Example.BenchmarkServer)) <> " ms")
    ElixirExample.Router.stop
  end

  defp execute_n_requests(0) do
    {:ok}
  end

  defp execute_n_requests(n) do
    {:ok} = make_request(generate_payload()) 
    execute_n_requests(n-1)
    {:ok}
  end

  defp generate_payload do

   document =  %{client_id: UUID.uuid4(), payload: "Eg.Benchmark"}
    payload = JSON.encode!(document)
    
  end

  defp uri do
    "http://localhost:4000/api/basic"
  end

  defp make_request(payload) do
    case HTTPoison.post(uri,payload) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Logger.info body
        {:ok}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        Logger.error "Not found :("
        {:error}
      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error "Server Error : #{reason}"
        {:error}
    end
  end
end
