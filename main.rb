require_relative "move"
require_relative "grid"

class TicTacToe
    def initialize
        loop do
            @grid = Grid.new()
            @current_turn = true
            winner = self.play
            case winner
            when :game_draw
                # draw
                puts "Draw"
            when :game_won
                puts "Player #{move = @current_turn ? "X" : "O"} won!"
            end
            print "Play again? (y/n): "
            break if gets.chomp.downcase == 'n'
        end
    end

    def play
        loop do
            @grid.draw_grid
            loop do
                move = prompt_for_move
                if not (move and @grid.is_valid? move)
                    puts "Invalid move. Try again."
                    next
                end

                case @grid.place_and_check move
                when :game_won
                    return :game_won
                when :game_draw
                    return :game_draw
                end
                
                @current_turn = !@current_turn
                break
            end
        end
    end

    def prompt_for_move
        move = @current_turn ? "X" : "O"
        print "Player #{move} - <row>, <column>: "
        selection = gets.chomp.strip

        regex = /\A(?<row>\d)\s*,?\s*(?<column>\d)\Z/
        if not regex.match? selection
            return nil
        end

        match_data = regex.match(selection)
        row = match_data["row"].to_i
        col = match_data["column"].to_i
        if (row < 1 or row > 3) or(col < 1 or col > 3)
            return nil
        end

        Move.new(move, row-1, col-1)
    end
end

TicTacToe.new
