defmodule ValueInListTest do
  use ExUnit.Case

  @hits Input.words()
  @misses Input.non_words()

  for strategy <- [BenchGuard, BenchMapSet, BenchPattern, BenchSets] do
    test "#{strategy}.bench is true for words" do
      for word <- @hits do
        assert unquote(strategy).bench(word) == true
      end
    end

    test "#{strategy}.bench is false for non words" do
      for word <- @misses do
        assert unquote(strategy).bench(word) == false
      end
    end
  end
end
