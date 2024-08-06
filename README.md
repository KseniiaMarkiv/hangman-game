# Hangman Game

Welcome to the Hangman Game! This project is a simple command-line game where players take turns guessing letters in a hidden word. The game features colorful outputs and interactive prompts.

## Table of Contents
- [Installation](#installation)
- [How to Play](#how-to-play)
- [Features](#features)
- [Example](#example)
- [Credits](#credits)

## Installation

To set up the Hangman Game on your local machine, follow these steps:

1. **Clone the Repository:**
   ```
   git clone https://github.com/yourusername/hangman-game.git
   ```
   ```
   cd hangman-game
  ```

2. **Install Dependencies:**
Make sure you have Ruby installed. Then, install the required gems by running:

  ```
    bundle install
  ```

3. **Set the Path for the Dictionary File:**
Ensure the path to the dictionary file (google-10000-english-no-swears.txt) is correct in your script. Update the PATH_FILE constant if necessary.


## How to Play

1. Run the game script:
  ```
    ruby hangman_game.rb
  ```

2. Choose your position:
  -  `h`: Hangman (sets the word for the player to guess)
  -  `p`: Player (guesses the word)
3. If you are the Hangman, choose a word between 5 to 12 letters.
4. If you are the Player, start guessing letters.
5. You have a maximum of 8 incorrect guesses before the game ends.

## Features

  -  **Interactive Gameplay**: Players can choose their roles and guess letters interactively.
  -  **Colorful Output**: The game uses the `colorize` gem to provide a colorful and engaging interface.
  -  **Word Selection**: Hangman can manually choose a word or let the game randomly select one from the dictionary file.
  -  **Save and Load Game**: Players can save their game state and load it later.
  -  **ASCII Art**: The game displays fun ASCII art for game over and congratulatory messages.

## Example

  ```
ruby hangman_game.rb
  ```

- Choose your position: `h` for Hangman, `p` for Player.
- Start guessing letters if you are the Player.
- The game will display the hangman stages as incorrect guesses are made.
- Save or continue the game as needed.

## Credits
This game was created using Ruby and the `colorize` gem. Special thanks to the developers of these tools for making this project possible.