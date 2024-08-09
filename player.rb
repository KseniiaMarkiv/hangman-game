class Player
  attr_reader :guessed_letters

  def initialize
    @guessed_letters = []
  end

  def guess_letter
    puts 'Write your letter, pls'
    letter = gets.chomp.downcase
    until valid_letter?(letter)
      letter = gets.chomp.downcase
    end
    puts "Is there letter #{letter} in your word?"
    letter
  end

  def add_guessed_letter letter
    @guessed_letters << letter
  end

  def letter_already_guessed? letter
    @guessed_letters.include?(letter)
  end

  private

  # rename from clean_display 
  def valid_letter?(letter)
    if letter.match?(/\A[a-zA-Z]\z/)
      true
    else
      puts "Invalid choice. Only letters are allowed and only 1 letter at a time.".colorize(:background => :red)
      false
    end
  end

end


