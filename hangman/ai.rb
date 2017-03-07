class Ai

  attr_accessor :word, :word_lgt

  def initialize
    crt_lst_posb_words
  end

#Create the list from the file
  def crt_lst_posb_words
    @possible_word = Array.new
    file = '5desk.txt'
    File.readlines(file).each do |line|
      if line.length > 4 && line.length < 13
        @possible_word.push(line.to_s)
      end
    end
  end

#Choose the word from the list
  def choose_word
    @word = ""
    rand_num = rand(@possible_word.length)
    @word = @possible_word[rand_num]
    @word_lgt = @word.length.to_i
  end

end
