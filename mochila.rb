require "matrix"
module Ed
  class Mochila
    attr_accessor :mochila_matrix, :takes

    def initialize(capacity, weights, values)
      @capacity, @weights, @values = capacity, weights, values
      @value_matrix = Ed::Board.new(values.count, capacity + 1)
      @takes = []
    end

    # BELLMAN
    def optimize value, row, col
      return 0 if col == 0
      return 0 if @weights[row] > col
      return @values[row] if row == 0 && @weights[row] < col
      value_a = @value_matrix.state[row - 1, col]
      value_b = @value_matrix.state[row - 1,  (col - @weights[row])]
      return [value_a.to_i, (value_b.to_i + @values[row])].max
    end

    def find_elements
      i = @values.count - 1
      k = @capacity
      while i >= 0 && k >= 0
        if @value_matrix.state[i,k] != @value_matrix.state[i-1,k]
          @takes << @weights[i]
          i -= 1
          k = k - @weights[k].to_i
        else
          i -= 1
        end
      end
      @takes
    end

    def run
      @value_matrix.state.each_with_index do |value, row, col|
        @value_matrix.state[row,col] = optimize(value, row, col)
      end
      print_matrix()
      puts "Takes Elements: #{find_elements()} Max benefit: #{@value_matrix.state[@values.count - 1, @capacity]}"
    end

    def print_matrix
      (0..(@value_matrix.state.row_count-1)).to_a.each do |row_number|
        puts "Element #{@weights[row_number]}: #{@value_matrix.state.row(row_number).map {|item| item == false ? "-" : (item)}.to_s.gsub("Vector", "")}"
      end
    end  

  end

  class Board
    attr_accessor :size_x, :size_y, :state
    def initialize(size_x, size_y, state=nil)
      @state = state || SetableMatrix.build(size_x, size_y) {|row, col| 0}
    end
  end

end

class SetableMatrix < Matrix
  public :"[]=", :set_element, :set_component
end
capacity = ARGV[0].to_i
weights = ARGV[1].to_s.split(",").map { |s| s.to_i }
values = ARGV[2].to_s.split(",").map { |s| s.to_i }
m = Ed::Mochila.new(capacity, weights, values)
m.run
