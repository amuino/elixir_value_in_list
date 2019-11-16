# ValueInList

Benchmark for different options of checking if a value is in a list/set known at compile time

## How to run

```
mix compile
mix test
mix bench
```

If your input file does not live in `/usr/share/dict/words`, export the environment variable `WORDS_FILE` with the actual path (or update `lib/data.ex`).

## Solutions benchmarked

- Guard condition `value in list`
- Pattern matching by generating multiple function heads at compile time for every element in the set
- Using Elixir's `MapSet` module
- Using Erlang's `sets` module

Of those, _Guard condition_ and (more noticeably) _Pattern matching_ have very long compile times as the number of elements in the set grows. On my system (iMac Retina 5K, 27-inch, Late 2014) compiling a set of 2.500 entries takes about 8 seconds.

Three scenarios are benchmarked, with 100% (all queried items are in the set), 50% and 0% hit rates.

## Results

- `HashSet` is the fastest solution, followed by _Pattern Matching_ (which is harder to implement and has the compile time issues described above, so not worth it).
- _Guard condition_ is the slowest. This matches the intuition that it needs to iterate over the list (`O(n)`), which is less efficient that a Set (`O(1)`) or pattern matching (compiles to a tree, so likely `O(log(n))`)
- Surprisingly, the erlang `sets` module is not even closer to the elixir `HashSet` and is even slower than _Pattern Matching_.
- I can't figure out why all solutions are slower the more hits on the input set. Makes me suspect a problem with my data or implementation.

```
- Running benchmark with 2500 words on the set
- Benchmark will lookup 1000 words per iteration (multiply ips by this factor)

...

##### With input 0% hit #####
Name                                ips        average  deviation         median         99th %
HashSet                         11.95 K       83.66 μs    ±14.32%       79.98 μs      141.98 μs
pattern matching on value        8.47 K      118.01 μs    ±11.44%      113.98 μs      183.98 μs
erlang sets                      5.56 K      179.84 μs    ±15.05%      170.98 μs      307.98 μs
guard: value in list           0.0694 K    14400.69 μs     ±6.79%    14103.98 μs    19261.78 μs

Comparison:
HashSet                         11.95 K
pattern matching on value        8.47 K - 1.41x slower +34.35 μs
erlang sets                      5.56 K - 2.15x slower +96.18 μs
guard: value in list           0.0694 K - 172.14x slower +14317.03 μs

##### With input 50% hit #####
Name                                ips        average  deviation         median         99th %
HashSet                         10.34 K       96.69 μs    ±15.95%       91.98 μs      170.98 μs
pattern matching on value        7.62 K      131.24 μs    ±12.00%      125.98 μs      207.98 μs
erlang sets                      5.13 K      194.95 μs    ±19.13%      178.98 μs      360.98 μs
guard: value in list           0.0862 K    11603.59 μs     ±4.49%    11518.98 μs    14405.08 μs

Comparison:
HashSet                         10.34 K
pattern matching on value        7.62 K - 1.36x slower +34.54 μs
erlang sets                      5.13 K - 2.02x slower +98.26 μs
guard: value in list           0.0862 K - 120.00x slower +11506.90 μs

##### With input 100% hit #####
Name                                ips        average  deviation         median         99th %
HashSet                          9.72 K      102.89 μs    ±14.80%       98.98 μs      183.98 μs
pattern matching on value        7.26 K      137.75 μs     ±9.95%      133.98 μs      203.98 μs
erlang sets                      5.15 K      194.00 μs    ±17.01%      180.98 μs      344.98 μs
guard: value in list            0.118 K     8493.88 μs     ±3.66%     8359.98 μs     9537.61 μs

Comparison:
HashSet                          9.72 K
pattern matching on value        7.26 K - 1.34x slower +34.87 μs
erlang sets                      5.15 K - 1.89x slower +91.12 μs
guard: value in list            0.118 K - 82.56x slower +8390.99 μs
```
