require_relative 'board.rb'
require_relative 'ai.rb'

require 'colorize'

require 'csv'

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
    if !(File.exist?("saves/saved_games.csv"))
      puts "There is no save."
      puts "Starting new game."
      game_start
    end

    puts "\nSaved Games:\n"
    saves = CSV.read("saves/saved_games.csv")
    saves.each_with_index do |save, index|
      puts "#{index + 1}. #{save[0]}"
    end
    load_save(saves)
    game_start
  end

  def load_save(saves)
    number = which_save(saves.size)
    @board.counter = saves[number][1].to_i
    @board.wrong_guess = saves[number][2].strip.split(//)
    @computer.word = saves[number][3].split(//)
    @board.board = saves[number][4].split(//)
    puts "#{saves[number][0]} loaded"
  end

  def which_save(number_of_saves)
    puts "\nput the number of the save you want to continue"
    answer = gets.chomp.to_i
    if answer < 1 || answer > number_of_saves
      puts "There's no save no.#{answer}."
      which_save(number_of_saves)
    else
      return answer - 1
    end
  end

  #Will call the creation of the board and the choosing of a word
  def game_start
    @computer.choose_word
    @board.create_board(@computer.word.length)
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
      elsif @guess == "save"
        save_game
      elsif @guess == "quit"
        quit_game
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
        if answer == "yes"
          Dir.mkdir('saves') unless File.exists?'saves'
          puts "Name of the save: "
          @name = gets.chomp
          csv = File.open("saves/saved_games.csv", "ab")
          csv.write("#{@name}, #{@board.counter}, #{@board.wrong_guess.join}, #{@computer.word.join()}, #{@board.board.join()}\n")
           csv.close
          puts "Game saved!"
        end
      else
        puts "Please write yes or no."
      end
    end
  end

  def quit_game
    answer = "unknow"
    until answer == "yes" || answer == "no"
      puts "Do you want to quit? Yes or no"
      answer = gets.chomp.downcase
      if answer == "yes" || answer == "no"
        if answer == "yes"
          abord("Goodbye")
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
