defmodule Data do
  @words_file System.get_env("WORDS_FILE", "/usr/share/dict/words")
  @num_words_to_take 2_500
  @all_words File.stream!(@words_file)
             |> Enum.map(&String.trim(&1))
             |> Enum.take(@num_words_to_take)
  @num_words_taken length(@all_words)

  def num_words, do: @num_words_taken

  def words, do: @all_words
end
