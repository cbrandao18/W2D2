require_relative "piece"
require_relative "slideable_pieces"
require_relative "stepable_pieces"
require_relative "pawn"
require_relative "nullpiece"

class Board
    attr_reader :rows

    def initialize
        @rows = Array.new(8){ Array.new(8, NullPiece.instance)}
        @sentinel
        populate_board()
    end

    def populate_board

        #Rook/Bishop/Queen & Knight/King
        @rows[0].each.with_index do |el, i|
            if i == 0 || i == 7
                @rows[0][i] = Rook.new(:light_red, self, [0,i])
            elsif i == 1 || i == 6
                @rows[0][i] = Knight.new(:light_red, self, [0,i])
            elsif i == 2 || i == 5
                @rows[0][i] = Bishop.new(:light_red, self, [0,i])
            elsif i == 3
                @rows[0][i] = King.new(:light_red, self, [0,i])
            elsif i == 4
                @rows[0][i] = Queen.new(:light_red, self, [0,i])
            end
        end

        #pawns
        @rows[1].each.with_index do |el, i|
           @rows[1][i] = Pawn.new(:light_red, self, [1, i])
        end
        
        # Everything in between here is NullPiece class

        #pawns
        @rows[6].each.with_index do |el, i|
            @rows[6][i] = Pawn.new(:light_blue, self, [6, i])
        end

        #Rook/Bishop/Queen & Knight/King
        @rows[7].each.with_index do |el, i|
            if i == 0 || i == 7
                @rows[7][i] = Rook.new(:light_blue, self, [7,i])
            elsif i == 1 || i == 6
                @rows[7][i] = Knight.new(:light_blue, self, [7,i])
            elsif i == 2 || i == 5
                @rows[7][i] = Bishop.new(:light_blue, self, [7,i])
            elsif i == 3
                @rows[7][i] = King.new(:light_blue, self, [7,i])
            elsif i == 4
                @rows[7][i] = Queen.new(:light_blue, self, [7,i])
            end
        end
    end

    class NullPieceError < ArgumentError
        def message
            "You can't start from a position that doesn't have a piece."
        end
    end

    class WrongMovePath < ArgumentError
        def message
            "You cannot move this piece to this position."
        end
    end

    #returning the board at the pos passed in
    def [](pos) #pos = [1,2]
        # x, y = pos
        x = pos[0]
        y = pos[1]
        @rows[x][y] 
    end

    #returns the board at the position passed in and also changes the value
    def []=(pos, val)
        x,y = pos
        @rows[x][y] = val
    end

    def move_piece(start_pos, end_pos)
        #check if start_pos is NullPiece. If it is, raise exception.
        if self[start_pos].class == NullPiece
            raise NullPieceError 
        end

        #check if piece can move to the end_pos. If not, raise exception,
        if self[start_pos].moves.include?(end_pos)
            raise WrongMovePath
        end

        #switching places
        self[end_pos]= self[start_pos]
        #set startpos to NullPiece
        self[start_pos]= NullPiece.instance
    end

    def valid_pos?(pos)
        x, y = pos
        x.between?(0,7) && y.between?(0,7)
    end

    def pieces(color)
        pieces_arr = []
        self.rows.each_with_index do |row, i|
            row.each_with_index do |piece, j|
                if piece.color == color
                    pieces_arr << piece
                end
            end
        end
        pieces_arr
    end

    #You can implement this by 
    #(1) finding the position of the King on the board then 
    #(2) seeing if any of the opposing pieces can move to that position.
    def in_check?(color)
        opponent_color = :light_red if color == :light_blue
        opponent_color = :light_blue if color == :light_red

        opponent_pieces = pieces(opponent_color)

        self.rows.each_with_index do |row, i|
            row.each_with_index do |piece, j|
                if piece.is_a?(King) && piece.color == color
                    king_pos = piece.pos
                    opponent_pieces.each do |piece|
                        opponents_piece_moves = piece.moves
                        if opponents_piece_moves.include?(king_pos)
                            return true
                        end
                    end
                end
            end
        end
        return false
    end



    #If the player is in check, and if none of the player's pieces have any 
    #valid_moves (to be implemented in a moment), then the player is in checkmate.
    def checkmate?(color)
        our_pieces = pieces(color)
        if in_check?(color) && our_pieces.all?{|piece| piece.valid_moves.empty?}
            return true
        end
        return false
    end

    def dup
        duped_board = Board.new()
        self.rows.each.with_index do |row, i|
            row.each.with_index do |piece, j|
                class_of_piece = piece.class
                if class_of_piece != NullPiece
                    duped_piece = class_of_piece.new(piece.color, duped_board, [i,j])
                    duped_board.rows[i][j] = duped_piece
                end
            end
        end
        duped_board
    end


    private
    attr_reader :sentinel
end
