class Ai

  def initialize
    @possible_word = Array.new

    File.open('5desk.txt','w') do |word|

      if word.lenght > 4 && word.length < 13
        @possible_word.push(word)
      end

    end
  end

  def choose_word
    word = ""
    word = @possible_word[rand(@possible_word.length)]
    return word
  end

end
