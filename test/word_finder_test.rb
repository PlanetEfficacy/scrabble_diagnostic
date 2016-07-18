gem 'minitest'
require_relative '../lib/word_finder'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class WordFinderTest < Minitest::Test

  def test_it_loads_in_the_entire_dictionary
    word_finder = WordFinder.new
    expected = 235886
    actual = word_finder.words.count
    binding.pry
    assert_equal expected, actual
  end
end
