defmodule BenchSets do
  @set Enum.reduce(Data.words(), :sets.new(), fn word, acc -> :sets.add_element(word, acc) end)

  def bench(word), do: :sets.is_element(word, @set)
end
