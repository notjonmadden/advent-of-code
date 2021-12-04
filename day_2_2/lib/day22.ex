defmodule Day2_2.Problem do
  defmodule Command do
    defstruct direction: nil, value: nil

    def parse(text) do
      [direction, distance] = String.split(text, " ")

      %Command{direction: direction, value: String.to_integer(distance)}
    end
  end

  defmodule State do
    defstruct depth: 0, distance: 0, aim: 0
  end

  def main(_args_) do
    final_state =
      File.read!("input.txt")
      |> String.split("\n")
      |> Enum.drop(-1)
      |> Enum.map(&Command.parse/1)
      |> Enum.reduce(%State{}, &evaluate/2)

    solution = final_state.distance * final_state.depth

    IO.puts(
      "traveled #{final_state.distance} with #{final_state.depth} in depth, final value is #{solution}"
    )
  end

  defp evaluate(%Command{direction: "down"} = cmd, state),
    do: %State{state | aim: state.aim + cmd.value}

  defp evaluate(%Command{direction: "up"} = cmd, state),
    do: %State{state | aim: state.aim - cmd.value}

  defp evaluate(%Command{direction: "forward"} = cmd, state) do
    depth = state.depth + state.aim * cmd.value
    distance = state.distance + cmd.value

    %State{state | depth: depth, distance: distance}
  end
end
