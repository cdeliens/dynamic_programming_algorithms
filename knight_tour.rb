require 'matrix'
module Ed

  class KnightTour
    attr_accessor :current_board, :size, :visited_moves, :initial_move, :animation

    def initialize(size, initial_move, animation)
      @size = size
      @current_board = build_board_with_state(Ed::ChessBoard.new(size, nil), initial_move)
      @current_move = visited_moves.last if @visited_moves
      @initial_move = initial_move
      @initial_time = Time.now
      @animation = animation
    end

    def build_board_with_state board, move
      new_board_with_move = Matrix.build(board.state.row_size, board.state.column_size) do |row, col|
        if [row, col] == move
          1
        else
          if board.state[row, col] != false
            2
          else
            board.state[row, col]
          end
        end
      end
      b = Ed::ChessBoard.new new_board_with_move.row_count, new_board_with_move
      current_move = move
      
      b
    end

    def backtracking(board=nil, move=nil)
      move ||= @initial_move
      board ||= @current_board
      neighboards(move).each do |m|
        if board.state.element(m[0], m[1]) == false && (m.first >= 0 && m.first < @size && m[1] >= 0 && m[1] < @size)
          new_board = build_board_with_state board, m
          if animation
            system("clear")
            puts "Execution time: #{(Time.now - @initial_time)/60*100} seconds"
            new_board.print 
          end
          backtracking new_board, m
        end
      end
      if board.is_over?
        puts "Execution time: #{(Time.now - @initial_time)/60*100} seconds"
        board.print
        abort("is Over")
      end
    end

    def neighboards move
      move_1 = [move.first - 1, move[1] + 2]
      move_2 = [move.first + 1, move[1] + 2]
      move_3 = [move.first - 1, move[1] - 2]
      move_4 = [move.first + 1, move[1] - 2]
      move_5 = [move.first + 2, move[1] - 1]
      move_6 = [move.first + 2, move[1] + 1]
      move_7 = [move.first - 2, move[1] - 1]
      move_8 = [move.first - 2, move[1] + 1]
      [move_1, move_2, move_3, move_4, move_5, move_6, move_7, move_8]
    end
  end

  class ChessBoard
    attr_accessor :size, :state
    def initialize(size, state)
      @size = size
      @state = state || Matrix.build(size, size) {|row, col| false}
    end

    def print
      (0..(state.row_count-1)).to_a.reverse.each do |row_number|
        puts "Row #{row_number}: #{state.row(row_number).map {|item| item == false ? "-" : (item == 1 ? print_horse : item.to_s.red)}.to_s.gsub("Vector", "")}"
      end
    end    

    def print_horse
      1.to_s.green
    end


    def is_over?
      state = true
      @state.each(:all) do |space|
        if space == false
          state = false 
        end
      end
      state
    end

  end
end

# This is just to color the results
class String

  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

end

board_size = ARGV[0].to_i
initial_position = ARGV[1].to_s.split(",").map { |s| s.to_i }
animation = ARGV[2] == "true" ? true : false
if board_size > 4 && initial_position.count > 0
  kt = Ed::KnightTour.new(board_size, initial_position, animation)
  kt.backtracking()
else
  puts "Review your inputs"
end

