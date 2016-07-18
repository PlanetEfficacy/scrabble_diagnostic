require 'csv'
class GameReader

 def read_game
   CSV.read("./test/input.csv")
 end

end
