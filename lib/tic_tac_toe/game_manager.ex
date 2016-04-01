defmodule TicTacToe.GameManager do
  alias TicTacToe.Game

  def start_link() do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def create_game(id, player1) do
    Game.start_link(%Game{id: id, player1: player1})
    Agent.update(__MODULE__, fn games -> [id | games] end)
    {:ok, id}
  end

  def join_game(player2) do
    game_to_join =
    Agent.get(__MODULE__, fn games -> games end)
    |> Enum.map(&Game.get/1)
    |> Enum.find(fn game -> game.player2 == nil end)

    case game_to_join do
      nil ->
        {:error, 404}
      _ ->
        joined_game = %{game_to_join | player2: player2}
        Game.update(joined_game.id, joined_game)
        {:ok, joined_game.id}
    end
  end

end
