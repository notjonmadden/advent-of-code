defmodule Day4.Input do
  alias Day4.Input
  alias Day4.Board

  defstruct numbers: [], boards: []

  def read do
    [numbers | lines] =
      File.read!("input.txt")
      |> String.split("\n")
      |> Enum.filter(&(&1 != ""))

    boards = Enum.chunk_every(lines, 5)

    %Input{
      numbers:
        numbers
        |> String.split(",", trim: true)
        |> Enum.map(&String.to_integer/1),
      boards: Enum.map(boards, &Board.from_input/1)
    }
  end
end
