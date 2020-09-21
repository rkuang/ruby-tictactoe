require_relative "move"

class Grid
    SIZE = 3

    def initialize
        @grid = Array.new(SIZE) {Array.new(SIZE)}
        @moves_left = SIZE**2
    end

    def is_valid? move
        not @grid[move.row][move.column]
    end

    def place_and_check move
        @grid[move.row][move.column] = move.move
        @moves_left -= 1

        if self.check_win move
            return :game_won
        elsif @moves_left == 0
            return :game_draw
        else
            return :game_continue
        end
    end

    def check_win move
        row_win = true
        @grid.size.times do |column|
            if move.move != @grid[move.row][column]
                row_win = false
                break
            end
        end

        col_win = true
        @grid.size.times do |row|
            if move.move != @grid[row][move.column]
                col_win = false
                break
            end
        end

        diag_win = true
        if move.row != move.column and move.row != SIZE-1-move.column
            diag_win = false
        else
            forward_slash = true
            @grid.size.times do |i|
                if move.move != @grid[i][i]
                    forward_slash = false
                    break
                end
            end
            back_slash = true
            @grid.size.times do |i|
                if move.move != @grid[i][SIZE-1-i]
                    back_slash = false
                    break
                end
            end
            diag_win = forward_slash || back_slash
        end
        return row_win || col_win || diag_win
    end


    def draw_grid
        puts "\n    1   2   3"
        @grid.size.times do |i|
            puts "  -------------"
            print "#{i+1} |"
            @grid.size.times do |j|
                print " #{@grid[i][j] ? @grid[i][j] : " "} |"
            end
            puts ""
        end
        puts "  -------------"
    end
end
