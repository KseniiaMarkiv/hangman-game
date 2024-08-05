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
path_file = 'D:\00_main_job\main\English\23_11_interview\Course\repos\hangman-game\google-10000-english-no-swears.txt'

words = File.readlines(path_file).map(&:chomp).select { |word| word.length.between?(5, 12) }
random_word = words.sample
puts random_word

def initialize_turns
  Array.new(8, ' ')
end

def display_letters(letter)
  puts " #{letter[0]}" + "#{letter[1]}" + "#{letter[2]} + #{letter[3]}" + "#{letter[4]}" + "#{letter[5]} + #{letter[6]}" + "#{letter[7]}" + "#{letter[8]}"
  puts ' _' + '_' + '_' + '_' + '_' + '_' + '_' + '_ '
end

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

current_players(choose_position)