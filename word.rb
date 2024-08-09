require 'colorize'
require_relative 'symbols'

class Word
  attr_reader :word

  def initialize
    @word = nil
  end

  def choose_word_from_file
    @word = File.readlines(PATH_FILE).map(&:chomp).select { |word| word.length.between?(5, 12) }.sample
  end

  def initialize_turns
    Array.new(@word.length, ' ')
  end

  # actions for Hangman
  def choose_custom_word
    puts ('Choose a word for the Player to guess:').colorize(:yellow)
    word = gets.chomp.downcase
    until word.match?(/\A[a-zA-Z]{5,12}\z/)
      puts ("Invalid choice. Please enter a word with 5 to 12 letters.").colorize(:background => :red)
      word = gets.chomp.downcase
    end
    @word = word
  end

  def display_spaces guessed_letters
    word = @word.chars.map { |char| guessed_letters.include?(char) ? char.colorize(:green) : '_' }.join(' ')
    puts
    puts word
    puts
  end

  def search_letter_in_word? letter
    @word.include?(letter)
  end
end