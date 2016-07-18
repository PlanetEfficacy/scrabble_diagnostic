require './lib/word_finder'
class Scrabble

  def score(word)
    valid_word?(word) ? score_word(word) : 0
  end

  def score_word(word)
    word.each_char.map do |letter|
      get_letter_point(letter)
    end.reduce(0, :+)
  end

  def get_letter_point(letter)
    valid_letter?(letter) ? point_values[validate(letter)] : 0
  end

  def validate(letter)
    letter.upcase
  end

  def valid_letter?(letter)
    ["a", "b", "c", "d", "e", "f", "g",
     "h", "i", "j", "k", "l", "m", "n",
     "o", "p", "q", "r", "s", "t", "u",
     "v", "w", "x", "y", "z", "A", "B",
     "C", "D", "E", "F", "G", "H", "I",
     "J", "K", "L", "M", "N", "O", "P",
     "Q", "R", "S", "T", "U", "V", "W",
     "X", "Y", "Z"].include?(letter)
  end

  def valid_word?(word)
    word_finder = WordFinder.new
    word_finder.words.include?(word)
  end

  def point_values
    {
      "A"=>1, "B"=>3, "C"=>3, "D"=>2,
      "E"=>1, "F"=>4, "G"=>2, "H"=>4,
      "I"=>1, "J"=>8, "K"=>5, "L"=>1,
      "M"=>3, "N"=>1, "O"=>1, "P"=>3,
      "Q"=>10, "R"=>1, "S"=>1, "T"=>1,
      "U"=>1, "V"=>4, "W"=>4, "X"=>8,
      "Y"=>4, "Z"=>10
    }
  end

  def score_with_multipliers(word, multipliers, word_multiplier=1)
    if word.length != 7
      score_with_multiplier(word, multipliers) * word_multiplier
    else
      (score_with_multiplier(word, multipliers) + 10) * word_multiplier
    end
  end

  def score_with_multiplier(word, multipliers)
    word.chars.map.with_index do |letter, index|
      get_letter_point(letter) * multipliers[index]
    end.reduce(:+)
  end

end
