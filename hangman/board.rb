class Board

  attr_accessor :counter, :board, :wrong_guess

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

  def check_previous_guess(x)
    if @wrong_guess.include?(x) || @board.include?(x)
      return true
    else
      return false
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
    if @wrong_guess.empty?
      puts "no guess yet."
    else
      @wrong_guess.each do |elem|
        print elem + ", "
      end
      puts ""
    end
  end

  def mark_board(word, guess)
    if word.include?(guess)
      #iteration avec guess + word
      word.each_with_index do |value, index|
        if guess == value
          @board[index] = guess
        end
      end
    else
      @wrong_guess.push(guess)
      @counter = @counter - 1
    end
  end

end
