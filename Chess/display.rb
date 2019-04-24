require_relative "board"
require_relative "cursor"
require "colorize"

class Display
    attr_reader :board, :cursor
    def initialize(board)
        @cursor = Cursor.new([0,0], board)
        @board = board
    end

    #"hello".colorize(:color => :light_red, :background => :white)
    def render
        self.board.rows.map.with_index do |row, i|
            row.map.with_index do |el, j|
                if el.is_a?(Piece) && [i,j] == self.cursor.cursor_pos
                    print " P ".colorize(:color => :light_red, :background => :white)
                elsif el.is_a?(Piece)
                    print " P ".colorize(:light_red) 
                elsif el.nil?
                    print " N ".colorize(:light_yellow)
                end
            end
            puts ""
        end
    end
end