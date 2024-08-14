This Ruby game project was performed in the [Odin course](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby#advanced-ruby)

# Hangman Game

Welcome to the Hangman Game! This project is a simple command-line game where players take turns guessing letters in a hidden word. The game features colorful outputs and interactive prompts.

## Table of Contents
- [Installation](#installation)
- [How to Play](#how-to-play)
- [Features](#features)
- [Example](#example)
- [Credits](#credits)
- [Refactoring Process](#refactoring)
- [You can improve](#you_can_improve)

## Installation

To install and run this game locally, follow these steps:

1. **Clone the Repository:**
   ```
   git clone https://github.com/KseniiaMarkiv/hangman-game.git
   ```
   
2. **Navigate to the project directory:**
   ```
   cd hangman-game
   ```
3. **Install Dependencies:**
  ```
    bundle install
  ```
4. **Set the Path for the Dictionary File:**
> [!WARNING]  
> Ensure the path to the dictionary file (google-10000-english-no-swears.txt) is correct in your script. Update the PATH_FILE constant if necessary.

## How to Play
1. Start the game:
   ```
   ruby hangman-game
   ```
2. The game will display a series of underscores representing the hidden word.
3. **Guess a letter** by typing it and pressing Enter.
4. If the letter is in the word, the corresponding underscores will be replaced with the correct letter.
5. If the letter is not in the word, a part of the hangman will be drawn.
6. The game ends when you either guess the word correctly or the hangman is fully drawn.

_at each stage the game asks you to save or continue_
**Good luck!**

## Features
- **ASCII Art:** Enjoy a visual representation of the hangman as you play.
- **Word Selection:** Randomly selects a word from a list of potential words.
- **Input Validation:** Ensures that player inputs are valid letters.
- **Configurable Settings:** You can easily adjust game settings like the number of turns and file paths for word lists.

### Explanation
- **Symbols Module:** Holds constants like file paths and the maximum number of turns. This makes changing the configuration easier.
- **Images Module:** Contains all methods related to displaying messages, ASCII art, etc.
- **Player Class:** Handles the player's guessed letters and input validation.
- **Word Class:** Manages the word logic, including word selection and display.
- **Hangman Class:** Orchestrates the game flow and interacts with other classes.

## Example

  ```
ruby main.rb
  ```

- Choose your position: `h` for Hangman, `p` for Player.
- Start guessing letters if you are the Player.
- The game will display the hangman stages as incorrect guesses are made.
- Save or continue the game as needed.

![alt text](https://github.com/KseniiaMarkiv/hangman-game/blob/start-game/show_first.png?raw=true)

<br>

- Game shows when you win and lose:

![alt text](https://github.com/KseniiaMarkiv/hangman-game/blob/start-game/show_over.png?raw=true)
<br>

![alt text](https://github.com/KseniiaMarkiv/hangman-game/blob/start-game/show_win.png?raw=true)

## Credits
This game was created using Ruby and the `colorize` gem. Special thanks to the developers of these tools for making this project possible.

This game was created by [Kseniia Markiv](https://github.com/KseniiaMarkiv). The project was developed to practice object-oriented programming in Ruby 

### Refactoring

> [!NOTE]  
> link to the beginning of this game
> [![](https://img.shields.io/badge/github-blue?style=for-the-badge)](https://github.com/KseniiaMarkiv/hangman-game/tree/start-game)

This section describes the refactoring steps that were undertaken to improve the structure, maintainability, and readability of the original codebase.

#### 1. **Class and Module Extraction**
   - **Symbols Module**: A dedicated `Symbols` module was created to encapsulate all the symbolic constants used in the game, such as emojis and `MAX_TURNS`. This prevents scattering of constants throughout the code and provides a single source of truth.
   - **Images Module**: ASCII art and related display methods were moved into an `Images` module. This encapsulates all visual elements, making them easier to manage and modify independently of the game logic.
   - **Player Class**: A `Player` class was introduced to handle player-specific logic, such as guessing letters and tracking guessed letters. This separation of concerns allows the game logic to focus on the overall flow of the game, while the player-specific logic is encapsulated within its own class.
   - **Word Class**: The logic for handling words, including selecting a word from a file and checking if a letter is in the word, was encapsulated in a `Word` class. This simplifies the main game logic and makes word-related functionalities reusable and easily testable.

#### 2. **Decoupling**
   - The original monolithic script was broken down into smaller, manageable components. This not only enhances readability but also allows for easier testing and debugging.
   - The game logic (`Hangman` class) is now decoupled from player interactions and word management. This separation allows each component to be modified independently without affecting the others.

#### 3. **Improved Modularity**
   - By using `require_relative`, the different modules and classes are now organized into separate files (`symbols.rb`, `images.rb`, `player.rb`, `word.rb`). This modularity makes the codebase easier to navigate and manage.
   - The `Hangman` class now serves as the controller, orchestrating the interaction between the `Player` and `Word` classes, while delegating visual aspects to the `Images` module.

#### 4. **Encapsulation of Logic**
   - Private methods were added to the `Hangman` class to encapsulate and organize logic that does not need to be exposed outside the class, such as `setup_new_game`, `load_game`, `save_game`, `load_game_state`, `process_guess`, `game_won?`, and `game_over?`.
   - This encapsulation adheres to the principle of least privilege, ensuring that only necessary methods and data are exposed.

#### 5. **Code Reusability**
   - The introduction of the `Player` and `Word` classes, along with their methods, promotes reusability across different parts of the game. For example, methods like `guess_letter`, `choose_word_from_file`, and `choose_custom_word` are now self-contained and can be reused or extended without altering the main game logic.

#### 6. **Error Handling and Input Validation**
   - Input validation for selecting positions (`h` or `p`) and ensuring valid letter guesses were centralized within the `Player` class. This enhances consistency and reduces redundancy in the code.
   - Error messages and prompts are more uniformly handled, providing a consistent user experience.

#### 7. **State Management**
   - Game state management was refactored to be more streamlined and cohesive. The game’s state, including the selected word, incorrect guesses, and guessed letters, is now managed as part of the `Hangman` class and saved to a YAML file when required.
   - The methods `save_game` and `load_game` handle the serialization and deserialization of the game state, providing a simple mechanism to persist and restore games.

This refactoring has led to a more organized, maintainable, and scalable codebase, making it easier to introduce new features, fix bugs, and enhance the game in the future.

## You can improve
1. accept of guessing the whole word;
2. make easier game when Hangman gives you a hint:
      - first letter;
      - last letter;
      - two identical letters in a word;
      - accept the whole word after 3 guess turns of Player;
3. an ability play by group of guessing players
