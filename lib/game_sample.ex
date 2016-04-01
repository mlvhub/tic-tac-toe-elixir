alias TicTacToe.GameManager
alias TicTacToe.Game

GameManager.start_link

p1 = %TicTacToe.Player{name: "Player1"}

{:ok, id} = GameManager.create_game(:game_id, p1)

IO.inspect Game.get(id)

p2 = %TicTacToe.Player{name: "Player2"}

GameManager.join_game(p2)

IO.inspect Game.print(id)

Game.play(id, 1, p1)
Game.play(id, 4, p2)

IO.inspect Game.print(id)
