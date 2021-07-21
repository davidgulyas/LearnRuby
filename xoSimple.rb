blank = '_'

def ContainsWinner(b, blank)
    for i in (0..2) do
        if b[i][0] != blank && b[i][0] == b[i][1] && b[i][0] == b[i][2]
            return true
        end

        if b[0][i] != blank && b[0][i] == b[1][i] && b[0][i]== b[2][i]
            return true
        end
    end

    if b[0][0] != blank && b[0][0] == b[1][1] && b[0][0] == b[2][2]
        return true
    end

    if b[0][2] != blank && b[0][2] == b[1][1] && b[0][2] == b[2][0]
        return true
    end
    
    return false
end

board = []
board.push [blank,blank,blank]
board.push [blank,blank,blank]
board.push [blank,blank,blank]

currentPlayer = 'o'

while !ContainsWinner(board, blank)
    currentPlayer = currentPlayer == 'x' ? 'o' : 'x'
    inputIsGood = false
    while !inputIsGood
        print "Enter column: "
        column = gets.chomp.to_i
        print "Enter row: "
        row = gets.chomp.to_i
    
        if row >= 0 && row <= 2 && column >= 0 && column <= 2 &&board[row][column] == '_'
            board[row][column] = currentPlayer
            inputIsGood = true
        else
            puts "bad input"
        end
    end
    
    puts board.map { |x| x.join(' ') }
end

puts "Winner: " + currentPlayer