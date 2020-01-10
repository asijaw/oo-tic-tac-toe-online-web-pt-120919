require 'pry'
class TicTacToe
  
  WIN_COMBINATIONS = [
    [0,1,2], #Top row
    [3,4,5], #Middle row
    [6,7,8], #Bottom row
    [0,4,8], #Left diagonal
    [2,4,6], #Right diagonal
    [0,3,6], #Left column
    [1,4,7], #Middle column
    [2,5,8]  #Right column
    ]
  def initialize
    @board = Array.new(9, " ")
  end
  
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  # Takes a string and converts it to an integer then changes the 1-9 to a 0-8 value by subtracting 1 
  def input_to_index(move_index)
    move_index.to_i - 1
  end
  
  # Accepts a position t move and a player and fills that space
  def move(pos_index, player = "X")
    @board[pos_index] = player
  end
  
  # Checks is a space is filled with an X or O 
  def position_taken?(position)
    @board[position] == "X" || @board[position] == "O" ? true : false
  end
    
  # Checks if a move is valid by checking that the number passed is on the board and that board space is not taken
  def valid_move?(position)
    (0..8).include?(position) && !position_taken?(position)
  end 
  
  # Asks the user to pick a space to new based on their 1-9 view, determines if the move is valid, makes the move, and dispalays the board. if move is invalid ask the user again
  def turn
    puts "Please enter 1-9"
    pos = gets.strip
    desired_move = input_to_index(pos)
    if valid_move?(desired_move)
      move(desired_move, current_player)
      display_board
    else
      turn
    end
  end
  
  #Counts the number of spaces filled 
  def turn_count
    @board.count {|space| space == "X" || space == "O"}
  end
  
  # Determines the current player by checking turn count. If count is even then it is X's turn if odd then O
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end
  
  # Checks WIN_COMBINATIONS array against the board to see of those spaces contain winnning combo
  def won?
    # a = WIN_COMBINATIONS.find{|combo|
    #   @board[combo[0]] == "X" && @board[combo[1]] == "X" && @board[combo[2]] == "X"
    # }
    # b = WIN_COMBINATIONS.find{|combo|
    #   @board[combo[0]] == "O" && @board[combo[1]] == "O" && @board[combo[2]] == "O"
    # }
    # return a || b

    
    WIN_COMBINATIONS.any? do |combo|
      if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
        return combo
      end 
    end 
  end
  
  # Checks if the board is full by comaping to num of turns taken
  def full?
    if turn_count == 9
      true
    end
    
  end
  
  # Determines if the game ends in a draw by checking if the board is full but the game is not won 
  def draw?
    !won? && full?
  end
   
  # Determines if the game is over by checking if the board is full or if someone has won
  def over?
    won? || draw?
  end
  
  # Checks who won the game by checking the winning combo's first position
  def winner 
    if won?
      @board[won?[0]] == "X" ? "X" : "O"
    else
      nil 
    end
  end
  
  # Game palying structure. Plays until the game is over. if someone won, congratulate winner if not tell how it ended. Ask for rematch, if yes start over if no end game.
  def play 
     turn until over?
     won? ? puts("Congratulations #{winner}!") : puts("Cat's Game!")
    # puts("Would you like to play again? (Y or N)")
    # gets.strip == "Y" ? play : puts("Goodbye!")
  end
end
    