class Player
    attr_reader :name
    def initialize(name)
        @name = name
    end
end


class Game

    @@board = Array (1..9)
    @@turnCounter = 0
    @@winningCondition = false

    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [6, 4, 2],
        [0, 4, 8]
      ]

    private

    def self.displayBoard(board=@@board)
        puts "\n"
        puts "#{board[0]} | #{board[1]} | #{board[2]}"
        puts separator = "----------"
        puts "#{board[3]} | #{board[4]} | #{board[5]}"
        puts separator
        puts "#{board[6]} | #{board[7]} | #{board[8]}"
    end

    def self.currentToken()
        @@turnCounter % 2 == 0 ? "O" : "X"
    end

    def self.currentPlayer()
        @@turnCounter % 2 == 0 ? @@player1.name : @@player2.name
    end

    def self.checkForWin(board=@@board)
        WIN_COMBINATIONS.detect do |combo|
            if board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]
                @@winningCondition = true
            end
          end
    end

    def self.turn()
        displayBoard
        puts currentPlayer + "'s turn :"
        move = gets.chomp.to_i
        if (@@board[move-1].is_a?(Integer) && move.between?(1,9))
            @@board[move-1] = currentToken
            @@turnCounter += 1
        else
            puts "Forbidden move!"
            return
        end
        return
    end

    public

    def self.setupPlayers()
        puts "Enter name for Player 1: "
        name = gets.chomp
        @@player1 = Player.new(name)
        puts "Enter name for Player 2: "
        name = gets.chomp
        @@player2 = Player.new(name)
    end


    def self.play
        until @@winningCondition == true || @@turnCounter == 9
            turn
            checkForWin
        end
        if @@turnCounter == 9
            puts "It's a draw"
            return
        end
        if @@winningCondition == true
            displayBoard
            @@turnCounter -= 1
            puts "Congratulations " + currentPlayer + ", You Won!"
            return
        end
    end

end

Game.setupPlayers
puts Game.play