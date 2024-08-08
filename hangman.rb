require 'colorize'
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
end

