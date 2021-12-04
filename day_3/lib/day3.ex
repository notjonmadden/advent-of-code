defmodule Day3.Problem do
  def main(_args) do
    # {zeroes, ones}
    bit_counts = for _ <- 1..12, do: {0, 0}

    {gamma, epsilon} =
      File.read!("input.txt")
      |> String.split("\n")
      |> Enum.drop(-1)
      |> Enum.reduce(bit_counts, &read_bit_counts/2)
      |> to_gamma_epsilon()

    IO.puts("gamma: #{gamma} | epsilon: #{epsilon} | power consumption: #{gamma * epsilon}")
  end

  defp to_gamma_epsilon(bit_counts) do
    {gamma, epsilon} =
      bit_counts
      |> Enum.map(&gamma_epsilon_bits/1)
      |> Enum.unzip()

    {bitlist_to_integer(gamma), bitlist_to_integer(epsilon)}
  end

  defp gamma_epsilon_bits({zeroes, ones}) do
    if ones > zeroes, do: {'1', '0'}, else: {'0', '1'}
  end

  defp bitlist_to_integer(bitlist) do
    bitlist |> Enum.join() |> String.to_integer(2)
  end

  defp read_bit_counts(binary, state) do
    binary
    |> String.graphemes()
    |> Enum.zip(state)
    |> Enum.map(&count_bit/1)
  end

  defp count_bit({"0", {zeroes, ones}}), do: {zeroes + 1, ones}
  defp count_bit({"1", {zeroes, ones}}), do: {zeroes, ones + 1}
end
