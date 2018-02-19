require_relative "players/manual_player"
require_relative "game_manager"

GameManager.new(ManualPlayer, 5, 5).play
