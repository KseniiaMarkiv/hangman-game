require 'colorize'
require_relative 'symbols'

class Player
  attr_reader :guessed_letters

  def initialize
    @guessed_letters = []
  end

  def guess_letter
    puts 'Write your letter, pls'
    letter = gets.chomp.downcase
    until clean_display(letter)
      letter = gets.chomp.downcase
    end
    puts "Is there letter #{letter} in your word?"
    letter
  end

  def clean_display letter
    unless letter.match?(/\A[a-zA-Z]\z/)
      puts ("Invalid choice. Only letters are allowed and only 1 letter at a time.").colorize(:background => :red)
      return false
    end
    true
  end

  def add_guessed_letter letter
    @guessed_letters << letter
  end

  def letter_already_guessed? letter
    @guessed_letters.include?(letter)
  end
end


