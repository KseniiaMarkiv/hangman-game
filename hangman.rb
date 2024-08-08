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
      @word.choose_custom_word
    elsif position == 'p'
      puts ("Player 1 plays Player position").colorize(:yellow)
      puts ("Player 2 plays Hangman position").colorize(:yellow)
      @word.choose_word_from_file
    else
      puts ("Invalid choice. Please choose 'h' or 'p'. #{MUSHROOM_EMOJI}").colorize(:background => :red)
      choose_position
    end
  end

# actions for Player
  def search_letter_in_word? letter_to_check
    @save_word.include?(letter_to_check)
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

  def play_game state = nil
    if state.nil?
      position = choose_position
      current_players(position)
      @incorrect_guesses = 0
      @player
    else
      @word.word, @incorrect_guesses, @player.guessed_letters = state
    end
   
    while @incorrect_guesses < MAX_TURNS
      @word.display_spaces(@player.guessed_letters)
      letter = @player.guess_letter
  
      if @player.letter_already_guessed?(letter)
        puts ("\n\nYou've already guessed the letter '#{letter}'. Try another one.").colorize(:yellow)
        next
      end
      
      @player.add_guessed_letter(letter)
  
      if @word.search_letter_in_word?(letter)
        sleep 1
        puts ("\n\nCorrect! The letter '#{letter}' is in the word.").colorize(:green)
      else
        sleep 1
        puts ("\n\nIncorrect. The letter '#{letter}' is not in the word.").colorize(:red)
        @incorrect_guesses += 1
      end
  
      self.class.display_hangman(@incorrect_guesses)
  
      if @word.word.chars.all? { |char| @player.guessed_letters.include?(char) }
        self.class.display_congrats_message
        puts CELEBRATION_SYMBOL + " You guessed the word '#{@save_word}'! " + CELEBRATION_SYMBOL
        break
      end
  
      if @incorrect_guesses == MAX_TURNS
        puts ("The word was '#{@word.word}'. \n").colorize(:red)
        self.class.display_game_over_message
      end
      
      choice = save_or_continue
      if choice == 's'
        save_game([@word.word, @incorrect_guesses, @player.guessed_letters])
        break
      end
  
    end
  end

  def main_menu
    puts ('Would you like to (s)tart a new game or (l)oad a saved game?').colorize(:color => :cyan)
    choice = gets.chomp.downcase
    until %w[s l].include?(choice)
      puts ('Invalid input. Please enter a valid string of s or l ' + "#{MUSHROOM_EMOJI}").colorize(:red)
      choice = gets.chomp.downcase
    end
  
    if choice == 'l'
      if File.exist?("D:/00_main_job/main/English/23_11_interview/Course/repos/hangman-game/saved_game.yaml")
        state = load_game
        play_game(state)
      else
        puts ("No saved game found. Starting a new game.").colorize(:red)
        play_game
      end
    else
      play_game
    end
  end
  

end

