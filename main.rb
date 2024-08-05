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
     /|\\  |
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

def turns_taken
  1
end

def message_for_players
  puts "You have #{MAX_TURNS - turns_taken} turns left."
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
def current_players(position)
  if position == 'h'
    puts yellow_color("Player 1 plays Hangman position")
    puts yellow_color("Player 2 plays Player position")
    ['h', 'p']
  elsif position == 'p'
    puts yellow_color("Player 1 plays Player position")
    puts yellow_color("Player 2 plays Hangman position")    
    ['p', 'h']
  else
    puts red_color("Invalid choice. Please choose 'X' or 'O'. #{MUSHROOM_EMOJI}")
    choose_position
  end
end

# actions for Hangman
def choose_word
  words = File.readlines(PATH_FILE).map(&:chomp).select { |word| word.length.between?(5, 12) }
  random_word = words.sample
  random_word
end

def initialize_turns(choose_word)
  Array.new(choose_word.length, ' ')
end


# display_letters to dynamically handle the length of the letters array
def display_letters(choose_word)
  # Print letters with spaces between them
  letters_display = choose_word.chars.join(' ')
  puts letters_display
  
  # Print underscores directly below each letter
  underscores_display = choose_word.chars.map { '_' }.join(' ')
  puts underscores_display
end




def play_game
  position = choose_position
  current_players(position)
  chosen_word = choose_word
  display_letters(chosen_word)
end

play_game
