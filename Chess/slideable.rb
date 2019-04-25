module Slideable

    HORIZONTAL_DIRS = [[-1,0],[1,0],[0,-1],[0,1]]
    DIAGONAL_DIRS = [[-1,-1],[-1,1],[1,-1],[1,1]]

    def horizontal_dirs
        HORIZONTAL_DIRS
    end

    def diagonal_dirs
        DIAGONAL_DIRS
    end

    #should return an array of places a Piece can move to. 
    #Uses grow_unblocked_moves_in_dir(dx, dy)
    def moves
        moves_arr = []
        move_dirs.each do |dir|
            dx, dy = dir
            moves_arr += grow_unblocked_moves_in_dir(dx, dy)
        end
        moves_arr
    end
    
    #Returns array of possible positions in that direction up until it hits 
    #another piece of the same color 
    #or the end of the board

    def grow_unblocked_moves_in_dir(dx, dy)
        possible_moves = []
        currentx, currenty = pos
        currentx, currenty = currentx + dx, currenty + dy
        pos_to_check = [currentx, currenty]
         while board.valid_pos?(pos_to_check) && board[pos_to_check].color != color
            possible_moves << pos_to_check
            currentx, currenty = currentx + dx, currenty + dy
            pos_to_check = [currentx, currenty]
         end
        possible_moves 
    end
end
