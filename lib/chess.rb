class Player 
    attr_reader :name, :symbol
    def initialize()
        @name = name_input()
        @symbol = symbol_input()
    end

    private
    def name_input()
        print "Enter your name: "
        gets.chomp
    end

    def symbol_input()
        print "Enter your symbol: "
        gets.chomp
    end
end

class Game
    attr_accessor :board
    attr_reader :player_1, :player_2

    def initialize() 
        @board = Array.new(8).map() {|i| i = Array.new(8)}
        puts "Player 1: "
        @player_1 = Player.new()
        puts "Player 2: "
        @player_2 = Player.new()
        @curr_turn = player_1
    end

    def move_piece(start, destination) 
        #valid_move() func will check if the piece is of the players as well as if destination is a possible move
        board[destination[0]][destination[1]] = board[start[0]][start[1]]
        board[start[0]][start[1]] = nil
        board[destination[0]][destination[1]].position = destination
        
    end

    def ask_input()
        print "Enter row [0-7]: "
        row = gets.chomp
        print "Enter column [0-7]: "
        column = gets.chomp

        return [row, column]
    end

    def valid_input(input) 
        until input[0].match?(/^[0-7]$/) && input[1].match?(/^[0-7]$/) do
            puts "Invalid Row or Column, try again."
            input = ask_input()

        end
        input[0] = input[0].to_i
        input[1] = input[1].to_i
        return input
    end

    def populate_player_piece(player)
        if player == player_2
            rows = [0, 1]
        else
            rows = [7, 6]
        end
        pieces = [Rook.new([rows[0], 0], player), Piece.new([rows[0], 1], player), Piece.new([rows[0], 2], player), Piece.new([rows[0], 3], player), Piece.new([rows[0], 4], player), Piece.new([rows[0], 5], player), Piece.new([rows[0], 6], player), Rook.new([rows[0], 7], player)]
        
        8.times do |index|
            board[rows[1]][index] = Piece.new([rows[1], index], player)
            board[rows[0]][index] = pieces[index]
        end
    end

    def display_board()
        display = ""
        8.times do |row|
            display += "|"
            board[row].each do |piece|
                if piece == nil 
                    display += "  |"
                else 
                    display += "#{piece.owner.symbol}#{piece.symbol}|"
                end
            end
            display += "\n"
        end
        display
    end
end

class Piece
    attr_reader :owner, :symbol
    attr_accessor :position, :moves
    def initialize(position, owner, symbol = 'P') 
        @position = position
        @owner = owner
        @symbol = symbol
        @moves = []
    end

end

class Rook < Piece
    
    #create possible_moves() instance method which returns the possible moves in a 2d array depending on current piece position
    #game will use this to determine of the move abides by the game rules
    #a rook can move horizontally and vertically, cannot jump pieces, front/backwards
    def initialize(position, owner, symbol = 'S')
        super
    end
    def possible_moves(position, board)
        moves = []
        
        moves += horizontal_moves(position, board)
        moves += vertical_moves(position, board)

        moves
    end

    def horizontal_moves(position, board)
        moves = []
        #grab current position
        row = position[0]
        column = position[1]
        #iterate through row grabbing horizontal pos that aren't occupied + ending if enemy piece
        front = column + 1
        back = column - 1
        until (front > 7 || board[row][front] != nil) && (back < 0 || board[row][back] != nil) do
            if front <= 7 && board[row][front].nil?
                moves << [row, front]
                front += 1
            end
            if back >= 0 && board[row][back].nil?
                moves << [row, back]
                back -= 1
            end
        end
        if front <= 7
            moves << [row, front]
        end
        if back >= 0
            moves << [row, back]
        end

        moves
    end

    def vertical_moves(position, board)
        moves = []
        #grab current position
        row = position[0]
        column = position[1]
        front = row - 1
        back = row + 1

        until (front < 0 || board[front][column] != nil) && (back > 7 || board[back][column] != nil) do
            if front >= 0 && board[front][column].nil?
                moves << [front, column]
                front -= 1
            end
            if back <= 7 && board[back][column].nil?
                moves << [back, column]
                back += 1
            end
        end

        if front >= 0
            moves << [front, column]
        end
        if back <= 7
            moves << [back, column]
        end

        moves
    end
end
=begin
game = Game.new()
game.populate_player_piece(game.player_1)
game.populate_player_piece(game.player_2)
game.move_piece(game.valid_input(game.ask_input()), game.valid_input(game.ask_input()))
#game.ask_input()
game.valid_input(['-5', '2'])

puts game.display_board
=end

game = Game.new()
game.populate_player_piece(game.player_1)
game.populate_player_piece(game.player_2)

puts game.display_board()
p game.board[7][0]