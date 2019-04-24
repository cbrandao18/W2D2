require_relative "piece"

class Board
    attr_reader :rows

    def initialize
        @rows = Array.new(8){ Array.new(8)}
        @sentinel

        #Rook/Bishop/Queen & Knight/King
        @rows[0].each.with_index do |el, i|
            @rows[0][i] = Piece.new
        end

        #pawns
        @rows[1].each.with_index do |el, i|
           @rows[1][i] = Piece.new
        end
        
        # Everything in between here is 'nil' but will be filled in with a 
        # NullPiece class that extends from Piece

        #pawns
        @rows[6].each.with_index do |el, i|
            @rows[6][i] = Piece.new
        end
        #Rook/Bishop/Queen & Knight/King
        @rows[7].each.with_index do |el, i|
            @rows[7][i] = Piece.new
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

    # We're going to rescue these where move_piece is called
    def move_piece(start_pos, end_pos)
        #check if start_pos is nil. If it is, raise exception.
        if self[start_pos].nil?
            raise NullPieceError 
        end

        #check if piece can move to the end_pos. If not, raise exception,
        # if self[start_pos].valid_moves.include?(end_pos)
        #     raise WrongMovePath
        # end

        #switching places
        self[end_pos]= self[start_pos]
        #set startpos to nil
        self[start_pos]= nil
    end

    private
    attr_reader :sentinel
end
