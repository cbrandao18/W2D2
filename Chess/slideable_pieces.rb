require_relative "piece"
require_relative "slideable"

class Bishop < Piece
    include Slideable
    
    def symbol
        " B ".colorize(color)
    end

    def move_dirs
        diagonal_dirs
    end
end

class Rook < Piece
    include Slideable

    def symbol
        " R ".colorize(color)
    end

    def move_dirs
        horizontal_dirs
    end

end

class Queen < Piece
    include Slideable

    def symbol
        " Q ".colorize(color)
    end

    def move_dirs
        diagonal_dirs + horizontal_dirs
    end

end