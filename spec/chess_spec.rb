require './lib/chess'

describe Game do
    describe '#move_piece' do
        subject(:game_move) {described_class.new()}

        context 'when prompted to move' do
            before do
                p1 = instance_double(Player, :name => 'brian', :symbol => '#')
                allow(Player).to receive(:new).and_return(p1)
                allow(game_move).to receive(:puts)
            end
            
            it 'moves to desired block' do
                game_move.populate_player_piece(game_move.player_1)
                piece = game_move.board[7][0]
                game_move.move_piece([7, 0], [5, 3])
                expect(game_move.board[5][3]).to be(piece)

            end
        end
    end
end