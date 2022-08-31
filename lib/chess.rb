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

    def populate_player_piece(player)
        if player == player_2
            rows = [0, 1]
        else
            rows = [7, 6]
        end
        pieces = ['Rook', 'Knight', 'Bishop', 'Queen', 'King', 'Bishop', 'Knight', 'Rook']
        8.times do |index|
            board[rows[1]][index] = Piece.new([1, index], 'Pawn', player)
            board[rows[0]][index] = Piece.new([0, index], pieces[index], player)
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
                    display += "#{piece.owner.symbol}#{piece.type[0]}|"
                end
            end
            display += "\n"
        end
        display
    end
end

class Piece
    attr_reader :position, :type, :owner
    def initialize(position, type, owner) 
        @position = position
        @type = type
        @owner = owner
        @moves = []
    end
end

game = Game.new()
game.populate_player_piece(game.player_1)
game.populate_player_piece(game.player_2)
puts game.display_board