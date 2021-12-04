defmodule Day2.Problem do
  defmodule Command do
    defstruct direction: nil, distance: nil

    def parse(text) do
      [direction, distance] = String.split(text, " ")

      %Command{direction: direction, distance: String.to_integer(distance)}
    end
  end

  def main(_args_) do
    {depth, distance} =
      File.read!("input.txt")
      |> String.split("\n")
      |> Enum.drop(-1)
      |> Enum.map(&Command.parse/1)
      |> Enum.reduce({0, 0}, &evaluate/2)

    IO.puts("traveled #{distance} with #{depth} in depth, final value is #{depth * distance}")
  end

  defp evaluate(%Command{direction: "down"} = cmd, {depth, distance}) do
    {depth + cmd.distance, distance}
  end

  defp evaluate(%Command{direction: "up"} = cmd, {depth, distance}) do
    {depth - cmd.distance, distance}
  end

  defp evaluate(%Command{direction: "forward"} = cmd, {depth, distance}) do
    {depth, distance + cmd.distance}
  end
end
