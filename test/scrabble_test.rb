gem 'minitest'
require_relative '../lib/scrabble'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class ScrabbleTest < Minitest::Test

  def test_it_can_score_anything
    game = Scrabble.new
    assert_equal 8, game.score("hello")
    assert_equal 0, game.score("")
    assert_equal 0, game.score(nil)
  end

  def test_it_can_score_a_single_word
    game = Scrabble.new
    assert_equal 8, game.score_word("hello")
    assert_equal 2, game.score_word("aa")
    assert_equal 20, game.score_word("zz")
    assert_equal 12, game.score_word("jesse")
    assert_equal 7, game.score_word("TURING")
    assert_equal 21, game.score_word("efficacy")
  end

  def test_it_knows_if_a_word_is_valid
    game = Scrabble.new
    assert game.valid_word?("hello")
    assert game.valid_word?("world")
    refute game.valid_word?("")
    refute game.valid_word?(nil)
    refute game.valid_word?([])
    refute game.valid_word?({})
    refute game.valid_word?("Here is an edge case.")
    refute game.valid_word?("!")
    refute game.valid_word?(false)
    refute game.valid_word?(true)
    refute game.valid_word?(10)
  end

  def test_it_can_score_a_single_letter
    assert_equal 1, Scrabble.new.get_letter_point("a")
    assert_equal 2, Scrabble.new.get_letter_point("d")
    assert_equal 3, Scrabble.new.get_letter_point("b")
    assert_equal 4, Scrabble.new.get_letter_point("f")
    assert_equal 5, Scrabble.new.get_letter_point("k")
    assert_equal 8, Scrabble.new.get_letter_point("j")
    assert_equal 10, Scrabble.new.get_letter_point("z")
    assert_equal 0, Scrabble.new.get_letter_point("")
    assert_equal 0, Scrabble.new.get_letter_point(nil)
    assert_equal 0, Scrabble.new.get_letter_point(" ")
    assert_equal 0, Scrabble.new.get_letter_point([])
    assert_equal 0, Scrabble.new.get_letter_point({})
    assert_equal 0, Scrabble.new.get_letter_point(1)
    assert_equal 0, Scrabble.new.get_letter_point("Foo Bar")
  end

  def test_it_can_validate_letter
    s = Scrabble.new

    assert_equal "A", s.validate("a")
    assert_equal "Z", s.validate("z")
  end

  def test_it_knows_if_a_letter_in_the_list_of_valid_letters
    s = Scrabble.new

    assert s.valid_letter?('a')
    assert s.valid_letter?('B')
    assert s.valid_letter?('x')
    assert s.valid_letter?('i')
    refute s.valid_letter?('')
    refute s.valid_letter?('1')
    refute s.valid_letter?(10)
    refute s.valid_letter?(' ')
    refute s.valid_letter?([])
    refute s.valid_letter?(nil)
    refute s.valid_letter?("word")
    refute s.valid_letter?("hello world")
  end

  def test_it_knows_all_letter_point_values
    one_point_letters = ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"]
    expected1 = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    two_point_letters = ["D", "G"]
    expected2 = [2, 2]
    three_point_letters = ["B", "C", "M", "P"]
    expected3 = [3, 3, 3, 3]
    four_point_letters = ["F", "H", "V", "W", "Y"]
    expected4 = [4, 4, 4, 4, 4]
    five_point_letters = ["K"]
    expected5 = [5]
    eight_point_letters = ["J", "X"]
    expected8 = [8, 8]
    ten_point_letters = ["Q", "Z"]
    expected10 = [10, 10]
    s = Scrabble.new

    actual1 = one_point_letters.map do |letter|
      s.point_values[letter]
    end

    actual2 = two_point_letters.map do |letter|
      s.point_values[letter]
    end

    actual3 = three_point_letters.map do |letter|
      s.point_values[letter]
    end

    actual4 = four_point_letters.map do |letter|
      s.point_values[letter]
    end

    actual5 = five_point_letters.map do |letter|
      s.point_values[letter]
    end

    actual8 = eight_point_letters.map do |letter|
      s.point_values[letter]
    end

    actual10 = ten_point_letters.map do |letter|
      s.point_values[letter]
    end

    assert_equal expected1, actual1
    assert_equal expected2, actual2
    assert_equal expected3, actual3
    assert_equal expected4, actual4
    assert_equal expected5, actual5
    assert_equal expected8, actual8
    assert_equal expected10, actual10
  end

  def test_it_can_score_with_multipliers
    game = Scrabble.new
    expected = 9
    expected2 = 10

    actual = game.score_with_multipliers("hello", [1,2,1,1,1])
    actual2 = game.score_with_multipliers("world", [1,2,1,1,1])

    assert_equal expected, actual
    assert_equal expected2, actual2
  end

  def test_it_can_score_with_multipliers_and_word_multipliers
    game = Scrabble.new
    expected = 18

    actual = game.score_with_multipliers("hello", [1,2,1,1,1], 2)

    assert_equal expected, actual
  end

  def test_it_adds_ten_points_for_seven_letter_words
    game = Scrabble.new
    expected = 58

    actual = game.score_with_multipliers("sparkle", [1,2,1,3,1,2,1], 2)

    assert_equal expected, actual
  end

  def test_it_scores_word_with_letter_multiplier
    game = Scrabble.new
    expected = 9

    actual = game.score_with_multiplier("hello", [1,2,1,1,1])

    assert_equal expected, actual
  end

end
