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

