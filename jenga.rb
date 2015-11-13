module Ed
  class Jenga
    attr_accessor :results
    def initialize(blocks, k, p)
      @b = Array.new(blocks)
      @k = k
      @p = p
      @results = []
    end

    def jenga index
      return false if index <= 0
      return true if index == 1 || index == @k || index == @p
      if !@results[(index-1)-1] || (!@results[(index-1)-@k] if index >= @k ) || (!@results[(index-1)-@p] if index >= @p)
        return true
      else
        return false
      end
    end

    def run
      @b.each_with_index do |block, index|
        @results << jenga(index+1)
      end
      @results.each_with_index do |r, i|
        puts "#{i+1}- #{r ? "W" : "L"}"
      end
    end
  end
end

play = Ed::Jenga.new ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i 
play.run