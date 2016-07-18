gem 'minitest'
require_relative '../lib/game_reader'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class GameReaderTest < Minitest::Test
  def test_it_can_read_games
    game_reader = GameReader.new
    expected = [["player_id", "word"],
                ["1", "hello"],
                ["2", "hi"],
                ["1", "silence"],
                ["2", "snacker"],
                ["1", "fun"]]

    assert_equal expected, game_reader.read_game
  end
end
