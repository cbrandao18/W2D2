require_relative "piece"
require_relative "stepable"

class King < Piece
    include Stepable

    def symbol
        " K ".colorize(color)
    end

    def move_diffs
        [[-1,0],
        [1,0],
        [0,-1],
        [0,1],
        [-1,-1],
        [-1,1],
        [1,-1],
        [1,1]]
    end
end

class Knight < Piece
    include Stepable

    def symbol
        " H ".colorize(color)
    end

    def move_diffs
        [[-2, -1],
        [-1, -2],
        [-2, 1],
        [-1, 2],
        [1, -2],
        [2, -1],
        [1, 2],
        [2, 1]]
    end
end