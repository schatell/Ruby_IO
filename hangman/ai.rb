class Ai

  attr_accessor :word

  def initialize

  end

  def choose_word
    dictonary = File.readlines("5desk.txt")
    random_line = rand(1..61405)
    @word = dictonary[random_line]
    while ((@word.length < 6) || (@word.length > 13))
      random_line = rand(1..61405)
      @word = dictonary[random_line]
    end
    @word.downcase.chomp
    @word = @word.strip.split(//)
  end

end
