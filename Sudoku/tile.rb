require 'colorize'
require 'colorized_string'
class Tile
    attr_reader :value
    def initialize(value)
        @value = value
        @given = is_given?
    end

    def is_given?
        !(@value == 0)
    end

    def to_s
        if @given
            @value.to_s.colorize(:green)
        else
            return @value.to_s.colorize(:white) if @value == 0
            @value.to_s.colorize(:light_blue)
        end
    end

    def value=(new_value)
        if @given
            puts "you cannot change this tile"
        else
            @value = new_value
        end
    end

    
end