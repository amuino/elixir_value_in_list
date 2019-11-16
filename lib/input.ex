defmodule Input do
  @length 1000
  def length, do: @length

  @words Data.words() |> Enum.shuffle() |> Enum.take(@length)
  def words, do: @words

  @non_words Enum.map(Data.words(), &"#{&1}-non-word") |> Enum.take(@length)
  def non_words, do: @non_words

  @mixed Enum.zip(@words, @non_words)
         |> Enum.map(&Tuple.to_list/1)
         |> List.flatten()
         |> Enum.take(@length)
  def mixed, do: @mixed
end
