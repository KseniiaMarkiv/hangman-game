require 'colorize'
require 'yaml'  # Ensure the yaml library is required

require_relative 'symbols'
require_relative 'images'
require_relative 'player'
require_relative 'word'

class Hangman

  def initialize
    @player = Player.new
    @word = Word.new
    @incorrect_guesses = 0
  end

  def main_menu
    puts ('Would you like to (s)tart a new game or (l)oad a saved game?\n').colorize(:color => :cyan)
    choice = gets.chomp.downcase
    until %w[s l].include?(choice)
      puts ('Invalid input. Please enter a valid string of s or l ' + "#{Symbols::MUSHROOM_EMOJI}").colorize(:red)
      choice = gets.chomp.downcase
    end
  
    if choice == 'l'
      load_game
    else
      play_game
    end
  end

  def play_game(state = nil)
    if state.nil?
      setup_new_game
    else
      load_game_state(state)
    end
   
    while @incorrect_guesses < Symbols::MAX_TURNS
      @word.display_spaces(@player.guessed_letters)
      turns_taken
      letter = @player.guess_letter
  
      if @player.letter_already_guessed?(letter)
        puts ("\n\nYou've already guessed the letter '#{letter}'. Try another one.").colorize(:yellow)
        next
      end
      
      @player.add_guessed_letter(letter)
      process_guess(letter)
  
      if game_won?
        Images.display_congrats_message
        puts (Symbols::CELEBRATION_SYMBOL + " You guessed the word '#{@word.word}'! " + Symbols::CELEBRATION_SYMBOL).colorize(:green)
        break
      elsif game_over?
        Images.display_game_over_message
        puts ("The word was '#{@word.word}'. \n").colorize(:red)
        break
      end

      choice = save_or_continue
      if choice == 's'
        save_game([@word.word, @incorrect_guesses, @player.guessed_letters])
        break
      end
    end
  end

  private

  def setup_new_game
    position = choose_position
    current_players(position)
    @incorrect_guesses = 0
    @player = Player.new
  end

  def load_game
    if File.exist?(File.join(Symbols::SAVED_PATH, 'saved_game.yaml'))
      state = YAML.load_file(File.join(Symbols::SAVED_PATH, 'saved_game.yaml'))
      play_game(state)
    else
      puts "No saved game found. Starting a new game.".colorize(:red)
      play_game
    end
  end

  def save_game state
    File.open(File.join(Symbols::SAVED_PATH, 'saved_game.yaml'), 'w') { |file| file.write(state.to_yaml) }
    puts "Game has been saved!".colorize(:green)
  end

  def load_game_state(state)
    @word.instance_variable_set(:@word, state[0])
    @incorrect_guesses = state[1]
    @player.instance_variable_set(:@guessed_letters, state[2])
  end

    # Choose position (Hangman or Player)
    def choose_position
      puts 'Choose your position h - Hangman or p - Player:'
      position = gets.chomp.downcase
      until %w[h p].include?(position)
        puts ('Invalid input. Please enter a valid string of h or p ' + "#{Symbols::MUSHROOM_EMOJI}").colorize(:background => :red)
        position = gets.chomp.downcase
      end
      position
    end
  
    # Assign positions to current players
    def current_players position
      if position == 'h'
        puts ("Player 1 plays Hangman position").colorize(:yellow)
        puts ("Player 2 plays Player position").colorize(:yellow)
        @word.choose_custom_word
      elsif position == 'p'
        puts ("Player 1 plays Player position").colorize(:yellow)
        puts ("Player 2 plays Hangman position").colorize(:yellow)
        @word.choose_word_from_file
      else
        puts ("Invalid choice. Please choose 'h' or 'p'. #{Symbols::MUSHROOM_EMOJI}").colorize(:background => :red)
        choose_position
      end
    end

    def process_guess(letter)
      if @word.search_letter_in_word?(letter)
        sleep 1
        puts ("\n\nCorrect! The letter '#{letter}' is in the word.").colorize(:green)
      else
        sleep 1
        puts ("\n\nIncorrect. The letter '#{letter}' is not in the word.").colorize(:red)
        @incorrect_guesses += 1
        Images.display_hangman(@incorrect_guesses)
      end
    end

    def game_won?
      @word.word.chars.all? { |char| @player.guessed_letters.include?(char) }
    end
  
    def game_over?
      @incorrect_guesses >= Symbols::MAX_TURNS
    end
  
    def turns_taken
      puts "\nPlayer has #{Symbols::MAX_TURNS - @incorrect_guesses} turns left.\n".colorize(:blue)
    end

    def save_or_continue
      puts ('Would you like to (s)ave the game or (c)ontinue playing?').colorize(:color => :cyan)
      choice = gets.chomp.downcase
      until %w[s c].include?(choice)
        puts ('Invalid input. Please enter a valid string of s or c ' + "#{Symbols::MUSHROOM_EMOJI}").colorize(:background => :red)
        choice = gets.chomp.downcase
      end
      choice
    end

end