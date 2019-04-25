require_relative "board"
require_relative "cursor"
require "colorize"

class Display
    attr_reader :board, :cursor, :debug
    def initialize(board)
        @cursor = Cursor.new([0,0], board)
        @board = board
        @debug = true

    end

    def render
        self.board.rows.map.with_index do |row, i|
            row.map.with_index do |el, j|
                if [i,j] == self.cursor.cursor_pos
                    print el.symbol.colorize(:color => el.color, :background => :white)
                else
                    print el.symbol
                end
            end
            puts ""
        end
    end

    def debug_output
        print "Rooks available moves:"
        p @board[[0,0]].valid_moves
        print "Pawns available moves:"
        p @board[[1,0]].valid_moves
        print "Bishops available moves:"
        p @board[[2,0]].valid_moves
        print "Queens available moves:"
        p @board[[3,0]].valid_moves
        print "Kings available moves:"
        p @board[[4,0]].valid_moves

        
    end

end

b = Board.new()
d = Display.new(b)
d.debug_output() if d.debug == true
