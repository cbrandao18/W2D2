class Piece

    attr_accessor :color, :board, :pos

    def initialize(color,board,pos)
        @color = color
        @board = board
        @pos = pos
    end

    # Duplicate the Board and perform the move
    # Look to see if the player is in check after the move (Board#in_check?)
    def move_into_check?(end_pos)
        duped = @board.dup
        duped.move_piece(@pos, end_pos)
        duped.in_check?(@color)
    end

    def valid_moves
        valid_moves_arr = []
        self.moves.each do |move|
           valid_moves_arr << move if !move_into_check?(move)
        end
        valid_moves_arr 
    end

    def to_s

    end

    def empty?
        false
    end

    def pos=(val)

    end

    def symbol

    end
    
end