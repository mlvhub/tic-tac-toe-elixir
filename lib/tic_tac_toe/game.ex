defmodule TicTacToe.Game do
  defstruct id: nil, boxes: [], player1: nil, player2: nil

  alias TicTacToe.Box

  @box_count 9

  def start_link(game = %TicTacToe.Game{id: id}) do
    loaded_game = load_boxes(game)
    Agent.start_link(fn -> loaded_game end, name: id)
  end

  def get(game_id) do
    Agent.get(game_id, &(&1))
  end

  def print(game_id) do
    game = get game_id

    player_moves_labels = 
    game.boxes
    |> Enum.map(fn box_id ->
      box = Box.get(box_id)
      case box.player do
        %TicTacToe.Player{name: name} ->
          name
        _ ->
          " "
      end
    end)

    player_moves_labels
    |> Enum.map(fn label -> "[#{label}]" end)
  end

  def update(game_id, game) do
    Agent.update(game_id, fn _ -> game end)
  end

  defp game_boxes(game_id) do
    game = get game_id

    game.boxes
    |> Enum.map(fn box_id -> Box.get(box_id) end)
  end

  def play(game_id, position, player) do
    box =
    game_boxes(game_id)
    |> Enum.find(fn box -> box.position == position end)

    case box.player do
      nil ->
        new_box = Box.update(box.id, %{box | player: player})
        {:ok, new_box}
      _ ->
        {:error, "Box is already occupied."}
    end
  end

  defp load_boxes(game) do
    boxes =
    1..@box_count
    |> Enum.map(fn num ->
      box = %TicTacToe.Box{id: String.to_atom("box#{num}"), position: num} 
      {:ok, box} = Box.start_link(box)
      box
    end)

    %{game | boxes: boxes}
  end
end
