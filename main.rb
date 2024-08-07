require 'colorize'
require 'yaml'  # Ensure the yaml library is required


# all constants of symbols
CELEBRATION_SYMBOL = "\u{1F389}"
RAINBOW_SYMBOL = "\u{1F308}"
COOL_EMOJI = "\u{1F60E}"
MUSHROOM_EMOJI = "\u{1F344}"
AIM_SYMBOL = "\u{1F3AF}"

# display some sort of count so the player knows how many more incorrect guesses they have before the game ends
MAX_TURNS = 8

# your script should load in the dictionary and randomly select a word between 5 and 12 characters
PATH_FILE = 'D:\00_main_job\main\English\23_11_interview\Course\repos\hangman-game\google-10000-english-no-swears.txt'

def display_hangman incorrect_guesses
  hangman_stages = [
    """
    """,
    """
      -----
          |
          |
          |
          |
          |
    """,
    """
      -----
          |
      O   |
          |
          |
          |
    """,
    """
      -----
          |
      O   |
      |   |
          |
          |
    """,
    """
      -----
          |
      O   |
      |\\ |
          |
          |
    """,
    """
      -----
          |
      O   |
     /|\\ |
          |
          |
    """,
    """
      -----
          |
      O   |
     /|\\  |
       \\  |
          |
    """,
    """
      -----
          |
      O   |
     /|\\  |
     / \\  |
          |
    """,
    """
      -----
      |   |
     [O]  |
     /|\\  |
     / \\  |
          |
    """
  ]

  puts hangman_stages[incorrect_guesses]
end

# ASCII Art object of letters Congrats
def display_congrats_message
  message = <<-MESSAGE
                                                                           ,d
                                                                       88
 ,adPPYba,  ,adPPYba,  8b,dPPYba,   ,adPPYb,d8 8b,dPPYba, ,adPPYYba, MM88MMM  ,adPPYba,
a8"     "" a8"     "8a 88P'   `"8a a8"    `Y88 88P'   "Y8 ""     `Y8   88     I8[    ""
8b         8b       d8 88       88 8b       88 88         ,adPPPPP88   88      `"Y8ba,
"8a,   ,aa "8a,   ,a8" 88       88 "8a,   ,d88 88         88,    ,88   88,    aa    ]8I
 `"Ybbd8"'  `"YbbdP"'  88       88  `"YbbdP"Y8 88         `"8bbdP"Y8   "Y888  `"YbbdP"'
                                    aa,    ,88
                                     "Y8bbdP"
  MESSAGE

  puts message.colorize(:green)
end

def display_game_over_message
  message = <<-MESSAGE
    ┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼
    ███▀▀▀██┼███▀▀▀███┼███▀█▄█▀███┼██▀▀▀
    ██┼┼┼┼██┼██┼┼┼┼┼██┼██┼┼┼█┼┼┼██┼██┼┼┼
    ██┼┼┼▄▄▄┼██▄▄▄▄▄██┼██┼┼┼▀┼┼┼██┼██▀▀▀
    ██┼┼┼┼██┼██┼┼┼┼┼██┼██┼┼┼┼┼┼┼██┼██┼┼┼
    ███▄▄▄██┼██┼┼┼┼┼██┼██┼┼┼┼┼┼┼██┼██▄▄▄
    ┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼
    ███▀▀▀███┼▀███┼┼██▀┼██▀▀▀┼██▀▀▀▀██▄┼
    ██┼┼┼┼┼██┼┼┼██┼┼██┼┼██┼┼┼┼██┼┼┼┼┼██┼
    ██┼┼┼┼┼██┼┼┼██┼┼██┼┼██▀▀▀┼██▄▄▄▄▄▀▀┼
    ██┼┼┼┼┼██┼┼┼██┼┼█▀┼┼██┼┼┼┼██┼┼┼┼┼██┼
    ███▄▄▄███┼┼┼─▀█▀┼┼─┼██▄▄▄┼██┼┼┼┼┼██▄
    ┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼
    ┼┼┼┼┼┼┼┼██┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼██┼┼┼┼┼┼┼┼┼
    ┼┼┼┼┼┼████▄┼┼┼▄▄▄▄▄▄▄┼┼┼▄████┼┼┼┼┼┼┼
    ┼┼┼┼┼┼┼┼┼▀▀█▄█████████▄█▀▀┼┼┼┼┼┼┼┼┼┼
    ┼┼┼┼┼┼┼┼┼┼┼█████████████┼┼┼┼┼┼┼┼┼┼┼┼
    ┼┼┼┼┼┼┼┼┼┼┼██▀▀▀███▀▀▀██┼┼┼┼┼┼┼┼┼┼┼┼
    ┼┼┼┼┼┼┼┼┼┼┼██┼┼┼███┼┼┼██┼┼┼┼┼┼┼┼┼┼┼┼
    ┼┼┼┼┼┼┼┼┼┼┼█████▀▄▀█████┼┼┼┼┼┼┼┼┼┼┼┼
    ┼┼┼┼┼┼┼┼┼┼┼┼███████████┼┼┼┼┼┼┼┼┼┼┼┼┼
    ┼┼┼┼┼┼┼┼▄▄▄██┼┼█▀█▀█┼┼██▄▄▄┼┼┼┼┼┼┼┼┼
    ┼┼┼┼┼┼┼┼▀▀██┼┼┼┼┼┼┼┼┼┼┼██▀▀┼┼┼┼┼┼┼┼┼
    ┼┼┼┼┼┼┼┼┼┼▀▀┼┼┼┼┼┼┼┼┼┼┼▀▀┼┼┼┼┼┼┼┼┼┼┼
    ┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼┼
  MESSAGE

  puts message.colorize(:red)
end

def turns_taken incorrect_guesses
   puts ("Player has #{MAX_TURNS - incorrect_guesses} turns left.").colorize(:blue)
end

# take a Hangman or Player position
def choose_position
  puts 'Choose your position h - Hangman or p - Player:'
  position = gets.chomp.downcase
  until %w[h p].include?(position)
    puts ('Invalid input. Please enter a valid string of h or p ' + "#{MUSHROOM_EMOJI}").colorize( :background => :red)
    position = gets.chomp.downcase
  end
  position
end

# Assign positions to current players
def current_players position
  if position == 'h'
    puts ("Player 1 plays Hangman position").colorize(:yellow)
    puts ("Player 2 plays Player position").colorize(:yellow)
    ['h', 'p']
    hangman_choose_word
  elsif position == 'p'
    puts ("Player 1 plays Player position").colorize(:yellow)
    puts ("Player 2 plays Hangman position").colorize(:yellow)
    ['p', 'h']
    choose_word
  else
    puts ("Invalid choice. Please choose 'X' or 'O'. #{MUSHROOM_EMOJI}").colorize( :background => :red)
    choose_position
  end
end

# actions for Hangman

def hangman_choose_word
  puts ('Choose a word for the Player to guess:').colorize(:yellow)
  word = gets.chomp.downcase
  until word.match?(/\A[a-zA-Z]{5,12}\z/)
    puts ("Invalid choice. Please enter a word with 5 to 12 letters.").colorize( :background => :red)
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
    puts ("Invalid choice. Only letters are allowed and only 1 letter at a time.").colorize( :background => :red)
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

def search_letter_in_word? word, letter_to_check
  word.include?(letter_to_check)
end

def save_game state
  File.open("D:/00_main_job/main/English/23_11_interview/Course/repos/hangman-game/saved_game.yaml", "w") { |file| file.write(state.to_yaml) }
  puts ("Game has been saved!").colorize(:green)
end

def load_game
  YAML.load_file("D:/00_main_job/main/English/23_11_interview/Course/repos/hangman-game/saved_game.yaml")
end

def save_or_continue
  puts ('Would you like to (s)ave the game or (c)ontinue playing?').colorize(:color => :cyan)
  choice = gets.chomp.downcase
  until %w[s c].include?(choice)
    puts ('Invalid input. Please enter a valid string of s or c ' + "#{MUSHROOM_EMOJI}").colorize( :background => :red)
    choice = gets.chomp.downcase
  end
  choice
end

def play_game state = nil
  if state.nil?
    position = choose_position
    save_word = current_players(position)
    incorrect_guesses = 0
    guessed_letters = []
    initialize_turns(save_word)
  else
    save_word, incorrect_guesses, guessed_letters = state
  end
 
  while incorrect_guesses < MAX_TURNS
    display_spaces(save_word, guessed_letters)
    turns_taken(incorrect_guesses)
    letter = guess_letter

    if guessed_letters.include?(letter)
      puts ("\n\nYou've already guessed the letter '#{letter}'. Try another one.").colorize(:yellow)
      next
    end
    guessed_letters << letter

    if search_letter_in_word?(save_word, letter)
      sleep 1
      puts ("\n\nCorrect! The letter '#{letter}' is in the word.").colorize(:green)
    else
      sleep 1
      puts ("\n\nIncorrect. The letter '#{letter}' is not in the word.").colorize(:red)
      incorrect_guesses += 1
    end

    display_hangman(incorrect_guesses)

    if save_word.chars.all? { |char| guessed_letters.include?(char) }
      display_congrats_message
      puts CELEBRATION_SYMBOL + " You guessed the word '#{save_word}'! " + CELEBRATION_SYMBOL
      break
    end

    if incorrect_guesses == MAX_TURNS
      puts ("The word was '#{save_word}'. \n").colorize(:red)
      display_game_over_message
    end

    # Display the word before asking to save or continue
    display_spaces(save_word, guessed_letters)
    
    choice = save_or_continue
    if choice == 's'
      save_game([save_word, incorrect_guesses, guessed_letters])
      break
    end

  end
end

def main_menu
  puts 'Would you like to (s)tart a new game or (l)oad a saved game?'
  choice = gets.chomp.downcase
  until %w[s l].include?(choice)
    puts ('Invalid input. Please enter a valid string of s or l ' + "#{MUSHROOM_EMOJI}").colorize( :background => :red)
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

main_menu