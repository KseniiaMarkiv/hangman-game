require 'colorize'
require 'yaml'  # Ensure the yaml library is required

require_relative 'symbols'
require_relative 'images'

class Hangman

  def initialize
    @incorrect_guesses = 0
    @guessed_letters = []
    @save_word = nil
  end

    # Display Hangman stages
    def self.display_hangman incorrect_guesses
      puts HANGMAN_STAGES[incorrect_guesses]
    end
  
    # Display congrats message
    def self.display_congrats_message
      puts CONGRATS_MESSAGE.colorize(:green)
    end
  
    # Display game over message
    def self.display_game_over_message
      puts GAME_OVER_MESSAGE.colorize(:red)
    end

  # Choose position (Hangman or Player)
  def choose_position
    puts 'Choose your position h - Hangman or p - Player:'
    position = gets.chomp.downcase
    until %w[h p].include?(position)
      puts ('Invalid input. Please enter a valid string of h or p ' + "#{MUSHROOM_EMOJI}").colorize(:background => :red)
      position = gets.chomp.downcase
    end
    position
  end

  # Assign positions to current players
  def current_players position
    if position == 'h'
      puts ("Player 1 plays Hangman position").colorize(:yellow)
      puts ("Player 2 plays Player position").colorize(:yellow)
      hangman_choose_word
    elsif position == 'p'
      puts ("Player 1 plays Player position").colorize(:yellow)
      puts ("Player 2 plays Hangman position").colorize(:yellow)
      choose_word
    else
      puts ("Invalid choice. Please choose 'h' or 'p'. #{MUSHROOM_EMOJI}").colorize(:background => :red)
      choose_position
    end
  end

  # actions for Hangman
  def hangman_choose_word
    puts ('Choose a word for the Player to guess:').colorize(:yellow)
    word = gets.chomp.downcase
    until word.match?(/\A[a-zA-Z]{5,12}\z/)
      puts ("Invalid choice. Please enter a word with 5 to 12 letters.").colorize(:background => :red)
      word = gets.chomp.downcase
    end
    word
  end

  def choose_word
    word = File.readlines(PATH_FILE).map(&:chomp).select { |word| word.length.between?(5, 12) }
    word.sample
  end

  def initialize_turns word
    Array.new(word.length, ' ')
  end

  def clean_display letter
    unless letter.match?(/\A[a-zA-Z]\z/)
      puts ("Invalid choice. Only letters are allowed and only 1 letter at a time.").colorize(:background => :red)
      return false
    end
    true
  end

  def display_spaces word, guessed_letters
    display_word = word.chars.map { |char| guessed_letters.include?(char) ? char.colorize(:green) : '_' }.join(' ')
    puts
    puts display_word
    puts
  end

# actions for Player
  def guess_letter
    puts 'Write your letter, pls'
    letter = gets.chomp.downcase
    until clean_display(letter)
      letter = gets.chomp.downcase
    end
    puts "Is there letter #{letter} in your word?"
    letter
  end

  def search_letter_in_word?(word, letter_to_check)
    word.include?(letter_to_check)
  end

  def save_game state
    File.open(File.join(SAVED_PATH, 'saved_game.yaml'), "w") { |file| file.write(state.to_yaml) }
    puts ("Game has been saved!").colorize(:green)
  end

  def load_game
    YAML.load_file(File.join(SAVED_PATH, 'saved_game.yaml'))
  end

  def save_or_continue
    puts ('Would you like to (s)ave the game or (c)ontinue playing?').colorize(:color => :cyan)
    choice = gets.chomp.downcase
    until %w[s c].include?(choice)
      puts ('Invalid input. Please enter a valid string of s or c ' + "#{MUSHROOM_EMOJI}").colorize(:background => :red)
      choice = gets.chomp.downcase
    end
    choice
  end

end

