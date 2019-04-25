class Piece

    attr_accessor :color, :board, :pos

    def initialize(color,board,pos)
        @color = color
        @board = board
        @pos = pos
    end

    def valid_moves
        
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

    def move_into_check?(end_pos)
        
    end
    
end