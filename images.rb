module Images

  # Hangman stages array
  HANGMAN_STAGES =  [
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

  # ASCII art for congrats message
  CONGRATS_MESSAGE = <<-MESSAGE
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

  # ASCII art for game over message
  GAME_OVER_MESSAGE = <<-MESSAGE
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
    
end