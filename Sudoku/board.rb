require_relative "tile.rb"
class Board
    def self.from_file(name)
        board = File.readlines(name)[0..-1].map do |line|
            line.strip.split("").map{|ele| Tile.new(ele.to_i)}
        end
    end

        attr_reader :grid
    def initialize(file_name)
        @grid = Board.from_file(file_name)
    end

    def render
        puts "  #{(0..8).to_a.join(" ")}"
        @grid.each_with_index do |sub, i|
            puts "#{i} #{sub.join(" ")}"
        end
        nil
    end


    def [](position) #gives the Tile.class at a given position
        row, column = position
        @grid[row][column]
    end

    def []=(position,new_value) #changes the VALUE of the Tile.class
        self[position].value = new_value
    end

    def solved?
        solved_rows? && solved_columns? && solved_squares?
    end





    #################### HELPER METHODS ##############################

    def solved_rows? #checks if ALL of the ROWS are solved
        grid.all?{|row| solved_row?(row)}
    end

    def solved_row?(arr) #check if ONE ROW is solved
        arr.inject(0){|acc, ele| acc + ele.value} == 45
    end

    def solved_columns? #check if ALL of the COLUMNS are solved
        (0..8).all?{|i| solved_column?(i)}
    end

    def solved_column?(num) #check if ONE COLUMn is solved
        @grid.inject(0){|acc, sub| acc + sub[num].value} == 45
    end

    def solved_squares? #checks if ALL the SQUARES are solved
        self.square.all? do |sq|
            sq.inject(0){|acc, ele| acc + ele.value} == 45
        end
    end

    def square #returns a 2D array that contains all the squares falttened WRONNNNGGG
        squares = []
        [0,3,6].each do |i1|
            [0,3,6].each do |i2|
                squares << grid[i1..(i1+2)].map{|sub| sub[i2..(i2+2)]}.flatten
            end

        end
        squares
    end


end