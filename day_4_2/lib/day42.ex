defmodule Day4_2.Problem do
  alias Day4_2.Input
  alias Day4_2.Board

  def main(_args) do
    input = Input.read()
    number_sets = for i <- 5..Enum.count(input.numbers), do: Enum.take(input.numbers, i)

    {winning_board, winning_numbers} =
      input.boards
      |> Enum.map(&find_winning_numbers(&1, number_sets))
      |> Enum.filter(&has_winning_numbers/1)
      |> Enum.max_by(fn {_, numbers} -> length(numbers) end)

    score = Board.score(winning_board, winning_numbers)

    IO.puts("winning score: #{score}")
  end

  defp has_winning_numbers({_board, numbers}), do: !is_nil(numbers)

  defp find_winning_numbers(board, number_sets) do
    {board, Enum.find(number_sets, &Board.has_won(board, &1))}
  end
end
