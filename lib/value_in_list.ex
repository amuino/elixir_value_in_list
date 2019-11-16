defmodule ValueInList do
  def bench do
    IO.puts("""

    BENCHMARK INFO:
    - Running benchmark with #{Data.num_words()} words on the set
    - Benchmark will lookup #{Input.length()} words per iteration (multiply ips by this factor)

    """)

    Benchee.run(
      %{
        "guard: value in list" => fn input -> loop(&BenchGuard.bench/1, input) end,
        "pattern matching on value" => fn input -> loop(&BenchPattern.bench/1, input) end,
        "HashSet" => fn input -> loop(&BenchMapSet.bench/1, input) end,
        "erlang sets" => fn input -> loop(&BenchSets.bench/1, input) end
      },
      inputs: %{
        "100% hit" => Input.words(),
        "50% hit" => Input.mixed(),
        "0% hit" => Input.non_words()
      },
      warmup: 0.5,
      time: 2
    )
  end

  defp loop(benchmarked, inputs) do
    for i <- inputs, do: benchmarked.(i)
  end
end
