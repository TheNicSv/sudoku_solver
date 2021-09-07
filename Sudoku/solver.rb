require_relative "board.rb"
class Solver
    attr_reader :board, :possible_values
    def initialize(file_name)
        @board = Board.new(file_name)
        @possible_values = Hash.new{|h,k| h[k] = []}
    end

    def all_tiles_value_finder
        board.grid.each_with_index do |sub_arr,row|
            sub_arr.each_with_index do |tile_class, column|
                if !tile_class.is_given?
                    possible_values_finder([row,column])
                end
            end
        end
    end


    def possible_values_finder(position) 
        possible = possible_values_column(position) + possible_values_row(position) + possible_values_square(position)
        possible.map! do |ele| 
            if possible.count(ele) == 3
                ele
            end
        end
        
        @possible_values[position] = possible.compact.uniq
    end

    def solve!
        @board.render
        until board.solved?
            self.all_tiles_value_finder
            self.single_value_finder
            self.single_value_column
            self.single_value_row
            self.single_value_square
        end
        @board.render
    end





    ############HELPER METHODS#######################

    


    def possible_values_column(position)
        row, column = position
        possible = [1,2,3,4,5,6,7,8,9]
        board.grid.each do |sub|
            if sub[column].value != 0 
                possible.delete(sub[column].value)
            end
        end
        possible
    end

    def possible_values_row(position)
        row, column = position
        possible = [1,2,3,4,5,6,7,8,9]
        board.grid[row].each do |tile|
            if tile.value != 0 
                possible.delete(tile.value)
            end
        end
        possible
    end

    def possible_values_square(position)
        possible = [1,2,3,4,5,6,7,8,9]
        board.square[get_square_number(position)].each do |tile|
            if tile.value != 0 
                possible.delete(tile.value)
            end
        end
        possible

    end


    def get_square_number(position)
        row, column = position
        i1 = 0
        i2 = 0
        if row < 3
            i1 = 0
        elsif row > 5
            i1 = 6
        else
            i1 = 3
        end

        if column < 3
            i2 = 0
        elsif column > 5
            i2 = 2
        else
            i2 = 1
        end

        i1 + i2
    end

    def single_value_finder #fills in all locations where theres only one póssible guess
        possible_values.each do |k,v|
            if v.count == 1
                assign_value(k,v[0])
            end
        end
    end

    def single_value_row #fills all locations where it is the only place that a number can enter in a row
        (0..8).each do |i|
            all_possible = []
            possible_values.each do |k,v|
                if k[0] == i
                    all_possible += v
                end
            end
            uniq = all_possible.map{|ele|ele if all_possible.count(ele)== 1}
            uniq.compact.each do |num|
                possible_values.each do |k,v|
                    if k[0] == i && v.include?(num)
                        assign_value(k,num)
                    end
                end
            end
        end

    end

    def single_value_column #fills all locations where it is the only place that a number can enter in a row
        (0..8).each do |i|
            all_possible = []
            possible_values.each do |k,v|
                if k[1] == i
                    all_possible += v
                end
            end
            uniq = all_possible.map{|ele|ele if all_possible.count(ele)== 1}
            uniq.compact.each do |num|
                possible_values.each do |k,v|
                    if k[1] == i && v.include?(num)
                        assign_value(k,num)
                    end
                end
            end
        end

    end

    def assign_value(pos, val)
        board[pos] = val
    end

    def single_value_square
        (0..8).each do |i|
            all_possible = []
            possible_values.each do |k,v|
                if get_square_number(k) == i
                    all_possible += v
                end
            end
            uniq = all_possible.map{|ele|ele if all_possible.count(ele)== 1}
            uniq.compact.each do |num|
                possible_values.each do |k,v|
                    if get_square_number(k) == i && v.include?(num)
                        print "#{k} #{num}"
                        assign_value(k,num)
                    end
                end
            end
        end

    end
end
