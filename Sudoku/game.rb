require_relative "board.rb"
class Game
    attr_reader :board
    def initialize(file_name)
        @board = Board.new(file_name)
    end

    def prompt
        return [get_position, get_value]
    end

    def assign_value(arr)
        pos, val = arr
        board[pos] = val
    end

    def run
        puts #lets start the game
        until board.solved?
            sleep(1)
            system("clear")
            board.render
            assign_value(prompt)
        end
        puts "You GOD DAMN WON WOW"
    end


    def get_position
        position = nil
        until valid_pos?(position)
            puts "Enter a position loke so ´1,0'"
            position = gets.chomp.split(",").map!{|el| el.to_i}
        end
        position
    end

    def valid_pos?(pos)
        pos.is_a?(Array) && pos.count == 2 && pos.all?{|ele| ele >= 0 && ele <= 8}
    end

    def valid_value?(val)
        val.is_a?(Integer) && val >= 0 && val <= 8
    end

    def get_value
        value = nil
        until valid_value?(value)
            puts "Enter the value at the position, the number has to be betwen 0 and 8"
            value = gets.chomp.to_i
        end
        value
    end
end