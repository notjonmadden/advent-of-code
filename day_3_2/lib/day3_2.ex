defmodule Day3_2.Problem do
  def main(_args) do
    values =
      File.read!("input.txt")
      |> String.split("\n")
      |> Enum.drop(-1)

    oxygen = rating(values, :oxygen) |> String.to_integer(2)
    co2 = rating(values, :co2) |> String.to_integer(2)

    IO.puts("oxygen: #{oxygen} | CO2: #{co2} | support rating: #{oxygen * co2}")
  end

  defp rating(values, system, bit_index \\ 0)

  defp rating([value], _system, _bit_index), do: value

  defp rating(values, system, bit_index) do
    {zeroes, ones} = count_bits_at(values, bit_index)
    check_bit = get_check_bit({zeroes, ones}, system)

    values
    |> Enum.filter(&(String.at(&1, bit_index) == check_bit))
    |> rating(system, bit_index + 1)
  end

  defp get_check_bit({zeroes, ones}, :oxygen), do: if(zeroes > ones, do: "0", else: "1")

  defp get_check_bit({zeroes, ones}, :co2), do: if(zeroes <= ones, do: "0", else: "1")

  defp count_bits_at(values, bit_index) do
    values
    |> Enum.map(&String.at(&1, bit_index))
    |> Enum.reduce({0, 0}, &count_bit/2)
  end

  defp count_bit("0", {zeroes, ones}), do: {zeroes + 1, ones}
  defp count_bit("1", {zeroes, ones}), do: {zeroes, ones + 1}
end
