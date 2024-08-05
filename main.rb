# all constants of symbols
CELEBRATION_SYMBOL = "\u{1F389}"
RAINBOW_SYMBOL = "\u{1F308}"
COOL_EMOJI = "\u{1F60E}"
MUSHROOM_EMOJI = "\u{1F344}"
AIM_SYMBOL = "\u{1F3AF}"


# your script should load in the dictionary and randomly select a word between 5 and 12 characters

path_file = 'D:\00_main_job\main\English\23_11_interview\Course\repos\hangman-game\google-10000-english-no-swears.txt'

words = File.readlines(path_file).map(&:chomp).select { |word| word.length.between?(5, 12) }
random_word = words.sample
puts random_word

# display some sort of count so the player knows how many more incorrect guesses they have before the game ends
MAX_TURNS = 8

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

display_hangman(6)

def turns_taken
  1
end

def message_for_players
  puts "You have #{MAX_TURNS - turns_taken} turns left."
end
message_for_players


