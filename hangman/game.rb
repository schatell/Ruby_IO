require_relative 'board.rb'
require_relative 'player.rb'
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
    @player = Player.new

    launch_program
  end

  #When the program is first launched, ask the player for a newgame or for a load
  def launch_program
    gametype = nil
    puts "Welcome to Hang-Man!"
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
    Screen.clear
    @computer.choose_word
    @board.create_board(@computer.word_lgt)
    @board.display_board
  end

  def turn

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

end

newgame = Game.new
