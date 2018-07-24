Battleships

2 player game created using Ruby. One player places the ships on the board and the other player tries to hit ships by guessing coordinates. The objective of the game is to sink all ships that have been placed.

To run game:

1. Download repository
2. If not already installed, install requirements with 'bundle install'
3. Update game modes:
   - open lib/run_battleships.rb file
   - ship_mode determines which type of player places ships on the board. Type '2' for a computer player and '3' for a human player.
   - player_mode determines which type of player guesses where the ships are. Type '4' for a human player and '5' for a computer player.
4. Run application with 'ruby lib/run_battleships.rb'

To run tests:

1. Use 'rspec' command



The object of Battleship is to try and sink all of the other player's before they sink all of your ships. All of the other player's ships are somewhere on his/her board.  You try and hit them by calling out the coordinates of one of the squares on the board.  The other player also tries to hit your ships by calling out coordinates.  Neither you nor the other player can see the other's board so you must try to guess where they are.
