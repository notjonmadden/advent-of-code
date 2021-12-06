defmodule Day1.Problem do
  defmodule Accumulator do
    defstruct total: 0, last: nil
  end

  def main(_args) do
    result =
      File.stream!("input.txt")
      |> Enum.map(&parse_integer/1)
      |> Enum.reduce(&count_depth_increases/2)

    IO.puts("#{result.total} increases in the input file")
  end

  def parse_integer(input_line), do: input_line |> String.trim() |> String.to_integer()

  defp count_depth_increases(depth, acc) when is_number(acc),
    do: %Accumulator{total: 0, last: depth}

  defp count_depth_increases(depth, %Accumulator{last: last} = acc) when depth <= last,
    do: %Accumulator{acc | last: depth}

  defp count_depth_increases(depth, acc),
    do: %Accumulator{total: acc.total + 1, last: depth}
end
