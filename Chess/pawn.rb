require "byebug"
class Pawn < Piece

    def symbol
        " P ".colorize(color)
    end

    #return all the positions you can move to based on where you are in the board
    #forward_steps + side_attacks
    def moves
        forward_steps + side_attacks
    end

    #private

    def at_start_row?
       x,y = pos
       return true if x==1 || x ==6
       false
    end
    

    #returns -1 or 1
    def forward_dir
        if color == :light_red
            return 1
        else
            return -1
        end
        
    end

    #calls at_start_row?
    #forward_steps returns the forward moves he can make
    def forward_steps
        x,y = pos
        fwdsteps=[]
        if at_start_row?
            if forward_dir==1
                newpos1 =[x+1,y]
                newpos2 =[x+2,y]
                fwdsteps << newpos1
                fwdsteps<< newpos2
            else
                newpos1 =[x-1,y]
                newpos2 =[x-2,y]
                fwdsteps << newpos1
                fwdsteps<< newpos2
            end
        else #if it's not at the start row
            if forward_dir ==1
                newpos =[x+1,y]
                fwdsteps << newpos
            else 
                newpos=[x-1,y]
                fwdsteps << newpos
            end
        end

        #remove moves in fwsteps that aren't possible because a piece is already there
        fwdsteps.each do |moves|
            fwdsteps.delete(moves) if !board[moves].is_a?(NullPiece) || !board.valid_pos?(moves)
        end
        fwdsteps
    end

    def side_attacks
        # debugger
        x,y =pos
        side_attacks_arr =[[x+1,y+1],[x+1,y-1]] if forward_dir ==1
        side_attacks_arr = [[x-1,y+1],[x-1,y-1]] if forward_dir == -1
        result = []
        side_attacks_arr.each do |move|

            if !board.valid_pos?(move)
                next
            end
            if board[move].is_a?(NullPiece)
                next
            end
            if board[move].color == color
                next
            end
            result << move
        end

        result
    end

    
    
end



