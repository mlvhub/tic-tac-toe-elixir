defmodule TicTacToe.GameManagerTest do
  use ExUnit.Case

  alias TicTacToe.GameManager

  setup do
    GameManager.start_link
  end

end
