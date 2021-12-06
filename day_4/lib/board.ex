defmodule Day4.Board do
  alias Day4.Board

  defstruct rows: [], columns: []

  def from_input(data) do
    rows = Enum.map(data, &parse_row/1)
    columns = transpose(rows)

    %Board{rows: rows, columns: columns}
  end

  defp parse_row(row) do
    row |> String.split(" ", trim: true) |> Enum.map(&String.to_integer/1)
  end

  defp transpose(rows) do
    for i <- 0..4, do: Enum.map(rows, &Enum.at(&1, i))
  end

  def has_won(%Board{} = b, numbers) do
    Enum.any?(b.rows ++ b.columns, &all_marked(&1, numbers))
  end

  defp all_marked(_, numbers) when length(numbers) < 5, do: false

  defp all_marked(line, numbers), do: line -- numbers == []

  def score(%Board{rows: rows}, numbers) do
    last = List.last(numbers)
    numbers = MapSet.new(numbers)

    last *
      (rows
       |> List.flatten()
       |> Enum.filter(&(!MapSet.member?(numbers, &1)))
       |> Enum.sum())
  end
end
