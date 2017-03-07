class Board

#Counter is 6 because the player can make 6 mistake
  def initialize
    @counter = 6
    @wrong_guess = Array.new
  end

#Create the board with the right number of hint.
  def create_board(x)
    @board = Array.new
    x.times do
      @board.push("_")
    end

  end

#Display the board
  def display_board
    puts ""
    print "Word: "
    @board.each do |elem|
      print elem + " "
    end
    if @counter > 1
      puts " "
      puts "Chances left: #{@counter}"
    else
      puts " "
      puts "Only one chance left!".colorize(:red)
    end
    puts ""
    print "Wrong guesses: "
    @wrong_guess.each do |elem|
      print elem
    end
  end

end
