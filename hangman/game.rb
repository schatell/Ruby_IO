require_relative 'board.rb'
require_relative 'ai.rb'

require 'colorize'

#When called clear the screen#
module Screen
  def self.clear
    print "\e[2J\e[f"
  end
end

class Game

  def initialize
    @board = Board.new
    @computer = Ai.new
    @game_won = false
    launch_program
  end

  #When the program is first launched, ask the player for a newgame or for a load
  def launch_program
    gametype = nil
    puts "---Welcome to Hang-Man!---"
    puts "Anytime during the game you can write"
    puts "save".colorize(:red) + " or " + "quit".colorize(:red)
    puts "to either save or quit your game"
    until gametype == "newgame" || gametype == "load"
      puts "For a new game, type " + "newgame.".colorize(:red)
      puts "To load an old game, type " + "load.".colorize(:red)
      gametype = gets.chomp.downcase
      if gametype == "newgame"
        game_start
      else
        load_game
      end
    end
  end

  def load_game

  end

  #Will call the creation of the board and the choosing of a word
  def game_start
    @computer.choose_word
    @board.create_board(@computer.word_lgt)
    Screen.clear
    game_loop
  end

  def game_loop
    until @board.counter == 0 || @game_won == true
      Screen.clear
      @board.display_board
      turn
      is_game_won?
      if @game_won == true
        victory
      end
      if @board.counter == 0
        puts "You lose"
      end
    end
  end

  def turn
    puts "Which letter do you wish to try?"
    @guess = ""
    until @board.check_previous_guess(@guess) == true && @guess.length == 1
      @guess = gets.chomp.downcase
      if @board.check_previous_guess(@guess) == false && @guess.length == 1
        @board.mark_board(@computer.word, @guess)
      elsif @board.check_previous_guess(@guess) == true
        puts "You already made this guess previously, please take another guess"
      else
        puts "Choose only one letter."
      end
    end
  end

  def save_game
    answer = nil
    until answer == "yes" || answer == "no"
      puts "Do you want to save your game?"
      answer = gets.chomp.downcase
      if answer == "yes" || answer == "no"
        if answer == yes
          #save
        else
          #dont save
        end
      else
        puts "Please write yes or no."
      end
    end
  end

  def quit?
    answer = "unknow"
    until answer == "yes" || answer == "no"
      puts "Do you want to quit? Yes or no"
      answer = gets.chomp.downcase
      if answer == "yes" || answer == "no"
        if answer == yes
          #quit
        else
          #dont quit
        end
      else
        puts "Please write yes or no."
      end
    end
  end

  def is_game_won?
    if @board.board == @computer.word
      @game_won = true
    end
  end

  def victory

  end

end

newgame = Game.new
