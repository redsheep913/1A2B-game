# 🧃1A2B Number Guessing Game

### Game Description
* Classic number reasoning game where players guess a 4-digit number with unique digits
* After each guess, players receive xAyB feedback:
  - A: Number of correct digits in correct positions
  - B: Number of correct digits in wrong positions
* Goal: Guess the correct number in minimum attempts

### Technical Overview
* Built with **SwiftUI** framework for iOS
* Uses **MVVM** architecture pattern
* Features:
  - Random answer generation
  - Input validation
  - Game history tracking
  - Reset functionality

### How to Play
* Enter any 4 unique digits (0-9)
* Example: If answer is 1234
  - Guess 1567 → 1A0B (1 is correct position)
  - Guess 2178 → 1B (2 exists but wrong position)
  - Guess 1234 → 4A0B (Victory!)
