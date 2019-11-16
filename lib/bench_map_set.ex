defmodule BenchMapSet do
  @set Enum.into(Data.words(), MapSet.new())

  def bench(word), do: MapSet.member?(@set, word)
end
