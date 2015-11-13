require "matrix"
module Ed
  class NeedlemanWarsh
    def initialize(gapi, gape, mismatch, match, word_a, word_b)
      @gapi, @gape, @mismatch, @match, @word_a, @word_b = gapi, gape, mismatch, match, word_a, word_b
      @word_a.insert(0, " ")
      @word_b.insert(0, " ") 
      @matrix = SetableMatrix.build(word_b.length, word_a.length) {|row, col| 0}
    end

    def nw i, j
      return @gapi * (i+j) if i == 0 || j == 0
      value_a = @matrix[i, j-1] + @gape
      value_b = @matrix[i-1, j] + @gapi
      value_c = @matrix[i-1, j-1] + sub_nw(i, j)
      
      return [value_a, value_b, value_c].max
    end

    def sub_nw i, j
      if @word_a[i] == @word_b[j]
        @match
      else
        @mismatch
      end
    end

    def run
      @matrix.each_with_index do |e, row, col|
        @matrix[row,col] = nw(row, col)
      end
      print_matrix
    end


    def print_matrix
      (0..(@matrix.row_count-1)).to_a.each do |row_number|
        puts "#{@matrix.row(row_number).map {|item| item == false ? "-" : (item)}.to_s.gsub("Vector", "")}"
      end
    end 

  end
end
class SetableMatrix < Matrix
  public :"[]=", :set_element, :set_component
end

gapi, gape, mismatch, match, word_a, word_b = ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i, ARGV[3].to_i, ARGV[4].dup, ARGV[5].dup
n = Ed::NeedlemanWarsh.new(gapi, gape, mismatch, match, word_a, word_b)
n.run