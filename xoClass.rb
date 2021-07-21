class Game

    def initialize
        @blank = '_'

        @board = []
        @board.push [@blank,@blank,@blank]
        @board.push [@blank,@blank,@blank]
        @board.push [@blank,@blank,@blank]
        
        @currentPlayer = 'o'
    end
    
    def GetBoardString 
        return @board.map { |x| x.join(' ') }
    end

    def IsInputGood(column, row)
        return row >= 0 && row <= 2 && column >= 0 && column <= 2 && @board[row][column] == '_'
    end

    def ContainsWinner
        for i in (0..2) do
            if @board[i][0] != @blank && @board[i][0] == @board[i][1] && @board[i][0] == @board[i][2]
                return true
            end
    
            if @board[0][i] != @blank && @board[0][i] == @board[1][i] && @board[0][i]== @board[2][i]
                return true
            end
        end
    
        if @board[0][0] != @blank && @board[0][0] == @board[1][1] && @board[0][0] == @board[2][2]
            return true
        end
    
        if @board[0][2] != @blank && @board[0][2] == @board[1][1] && @board[0][2] == @board[2][0]
            return true
        end
        
        return false
    end

    def MakeMove(column, row)
        @currentPlayer = @currentPlayer == 'x' ? 'o' : 'x'
        @board[row][column] = @currentPlayer
    end

    def GetCurrentPlayer
        return @currentPlayer
    end

end

game = Game.new()

loop do #each iteration is a turn
    puts game.GetBoardString
    loop do #get valid input
        print "Enter column: "
        @column = gets.chomp.to_i
        print "Enter row: "
        @row = gets.chomp.to_i
        
        if game.IsInputGood(@column, @row)
            break
        end
        puts "bad input"
    end
    game.MakeMove(@column, @row)

    if game.ContainsWinner()
        break
    end
end

puts game.GetBoardString
puts "Winner: " + game.GetCurrentPlayer