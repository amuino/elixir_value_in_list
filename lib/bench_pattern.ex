defmodule BenchPattern do
  def bench(word)

  for word <- Data.words() do
    def bench(unquote(word)), do: true
  end

  def bench(_), do: false
end
