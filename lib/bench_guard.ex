defmodule BenchGuard do
  @words Data.words()
  def bench(word) when word in @words, do: true
  def bench(_), do: false
end
