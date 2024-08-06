require 'colorize'
# * colorizing methods

def blue_color(string)
  string.colorize(:blue)
end

def yellow_color(string)
  string.colorize(:yellow)
end

def green_color(string)
  string.colorize(:green)
end

def red_color(string)
  string.colorize(:red)
end

def gray_color(string)
  string.colorize(:gray)
end

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

def display_hangman(incorrect_guesses)
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
    --------
    """,
    """
      -----
          |
      O   |
          |
          |
          |
    --------
    """,
    """
      -----
          |
      O   |
      |   |
          |
          |
    --------
    """,
    """
      -----
          |
      O   |
      |\\ |
          |
          |
    --------
    """,
    """
      -----
          |
      O   |
     /|\\ |
          |
          |
    --------
    """,
    """
      -----
          |
      O   |
     /|\\  |
       \\  |
          |
    --------
    """,
    """
      -----
          |
      O   |
     /|\\  |
     / \\  |
          |
    --------
    """,
    """
      -----
      |   |
     [O]  |
     /|\\  |
     / \\  |
          |
    --------
    """
  ]

  puts hangman_stages[incorrect_guesses]
end

def turns_taken incorrect_guesses
   puts blue_color("You have #{MAX_TURNS - incorrect_guesses} turns left.")
end

# take a Hangman or Player position
def choose_position
  puts 'Choose your position h - Hangman or p - Player:'
  position = gets.chomp.downcase
  until %w[h p].include?(position)
    puts red_color('Invalid input. Please enter a valid string of h or p ' + "#{MUSHROOM_EMOJI}")
    position = gets.chomp.downcase
  end
  position
end

# Assign positions to current players
def current_players position
  if position == 'h'
    puts yellow_color("Player 1 plays Hangman position")
    puts yellow_color("Player 2 plays Player position")
    ['h', 'p']
    hangman_choose_word
  elsif position == 'p'
    puts yellow_color("Player 1 plays Player position")
    puts yellow_color("Player 2 plays Hangman position")
    ['p', 'h']
    choose_word
  else
    puts red_color("Invalid choice. Please choose 'X' or 'O'. #{MUSHROOM_EMOJI}")
    choose_position
  end
end

# actions for Hangman

def hangman_choose_word
  puts yellow_color('Choose a word for the Player to guess:')
  word = gets.chomp.downcase
  until word.match?(/\A[a-zA-Z]{5,12}\z/)
    puts red_color("Invalid choice. Please enter a word with 5 to 12 letters.")
    word = gets.chomp.downcase
  end
  word
end

def choose_word
  word = File.readlines(PATH_FILE).map(&:chomp).select { |word| word.length.between?(5, 12) }
  word.sample
end
# current_players(position) == 'h' ? puts 'Choose a word for Hangman: ' : 
def initialize_turns word
  Array.new(word.length, ' ')
end

def clean_display letter
  unless letter.match?(/\A[a-zA-Z]\z/)
    puts red_color("Invalid choice. Only letters are allowed and only 1 letter at a time.")
    return false
  end
  true
end

def display_spaces word, guessed_letters
  display_word = word.chars.map { |char| guessed_letters.include?(char) ? green_color(char) : '_' }.join(' ')
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

def play_game
  position = choose_position
  # current_players(position)

  save_word = current_players(position)
  incorrect_guesses = 0
  guessed_letters = []
  initialize_turns(save_word)
 
  while incorrect_guesses < MAX_TURNS
    display_spaces(save_word, guessed_letters)
    turns_taken(incorrect_guesses)
    letter = guess_letter

    if guessed_letters.include?(letter)
      puts yellow_color("\n\nYou've already guessed the letter '#{letter}'. Try another one.")
      next
    end

    guessed_letters << letter

    if search_letter_in_word?(save_word, letter)
      sleep 1
      puts green_color("\n\nCorrect! The letter '#{letter}' is in the word.")
    else
      sleep 1
      puts red_color("\n\nIncorrect. The letter '#{letter}' is not in the word.")
      incorrect_guesses += 1
    end
    
    display_hangman(incorrect_guesses)

    if save_word.chars.all? { |char| guessed_letters.include?(char) }
      puts CELEBRATION_SYMBOL + " You guessed the word '#{save_word}'! " + CELEBRATION_SYMBOL
      break
    end

    if incorrect_guesses == MAX_TURNS
      puts red_color("Game over! The word was '#{save_word}'.")
    end
  end
end

play_game