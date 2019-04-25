module Stepable
    
    def moves
        possible_moves = []
        #iterating through move_diffs
        move_diffs.each do |diff|
            currentx, currenty = pos
            dx, dy = diff
            currentx, currenty = currentx + dx, currenty + dy
            pos_to_check = [currentx, currenty]
            if board.valid_pos(pos_to_check) && board[pos_to_check].color != color
                possible_moves << pos_to_check
            end
        end
        possible_moves
    end

end