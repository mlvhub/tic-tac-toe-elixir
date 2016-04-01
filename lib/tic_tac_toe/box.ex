defmodule TicTacToe.Box do
  defstruct id: nil, position: nil, player: nil

  alias TicTacToe.Player

  def start_link(box = %TicTacToe.Box{id: id}) do
    Agent.start_link(fn -> box end, name: id)
  end

  def get(box_id) do
    Agent.get(box_id, &(&1))
  end

  def update(id, box) do
    Agent.update(id, fn _ -> box end)
  end

end
