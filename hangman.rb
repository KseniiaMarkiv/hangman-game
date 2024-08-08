require 'colorize'
require 'yaml'  # Ensure the yaml library is required

require_relative 'symbols'
require_relative 'images'

class Hangman

  def initialize
    @incorrect_guesses = 0
    @guessed_letters = []
    @save_word = nil
    @display_word = []
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
    @save_word = word
    @display_word = Array.new(@save_word.length, '_')
  end

  def choose_word
    @save_word = File.readlines(PATH_FILE).map(&:chomp).select { |word| word.length.between?(5, 12) }.sample
    @display_word = Array.new(@save_word.length, '_')
  end

  def clean_display letter
    unless letter.match?(/\A[a-zA-Z]\z/)
      puts ("Invalid choice. Only letters are allowed and only 1 letter at a time.").colorize(:background => :red)
      return false
    end
    true
  end

  def display_spaces
    display_word = @save_word.chars.map { |char| @guessed_letters.include?(char) ? char.colorize(:green) : '_' }.join(' ')
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
      @guessed_letters = []
    else
      @save_word, @incorrect_guesses, @guessed_letters = state
    end
   
    while @incorrect_guesses < MAX_TURNS
      display_spaces
      letter = guess_letter
  
      if @guessed_letters.include?(letter)
        puts ("\n\nYou've already guessed the letter '#{letter}'. Try another one.").colorize(:yellow)
        next
      end
      @guessed_letters << letter
  
      if search_letter_in_word?(letter)
        sleep 1
        puts ("\n\nCorrect! The letter '#{letter}' is in the word.").colorize(:green)
      else
        sleep 1
        puts ("\n\nIncorrect. The letter '#{letter}' is not in the word.").colorize(:red)
        @incorrect_guesses += 1
      end
  
      self.class.display_hangman(@incorrect_guesses)
  
      if @save_word.chars.all? { |char| @guessed_letters.include?(char) }
        self.class.display_congrats_message
        puts CELEBRATION_SYMBOL + " You guessed the word '#{@save_word}'! " + CELEBRATION_SYMBOL
        break
      end
  
      if @incorrect_guesses == MAX_TURNS
        puts ("The word was '#{@save_word}'. \n").colorize(:red)
        self.class.display_game_over_message
      end
      
      choice = save_or_continue
      if choice == 's'
        save_game([@save_word, @incorrect_guesses, @guessed_letters])
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

