require 'pry'
module Ed
  class Automata
    attr_accessor :states, :alphabet, :edges, :initial_state, :current_state
    def initialize(states, alphabet)
      @states, @alphabet= states, alphabet
      @initial_state = @states.first
      @current_state = @initial_state
    end

    def validate_state state, char
      return_state = nil
      state.edges.each do |edge|
        if edge.alphabet_letter == char
          return_state = edge.destination
        end
      end
      return_state
    end

    def valid?(evaluated_string)
      valid_state = false
      puts "Word to evaluate: #{evaluated_string}"
      evaluated_string.each_char.with_index do |char, index|
        puts "Evaluating Char: #{char}"
        puts "Current State: #{@current_state.name.upcase}"
        if @alphabet.include? char
          @current_state = validate_state(@current_state, char)
          if current_state != nil
            if (index+1) == evaluated_string.length && @current_state.acceptance == true
              valid_state = true
            end
          else
            @current_state = @initial_state
          end
        end
      end
      puts "State: #{valid_state.to_s.upcase}"
      valid_state
    end
    
  end

  class Edge
    attr_accessor :alphabet_letter, :destination
    def initialize(alphabet_letter, destination)
      @alphabet_letter, @destination = alphabet_letter, destination
    end
  end

  class State
    attr_accessor :name, :acceptance, :edges
    def initialize(name, acceptance)
      @name, @acceptance= name, acceptance
    end
  end
end


class String
  def to_bool
    return true if self =~ (/^(true|t|yes|y|1)$/i)
    return false if self.empty? || self =~ (/^(false|f|no|n|0)$/i)
    raise ArgumentError.new "invalid value: #{self}"
  end
end

# states = []
# states_continue_flag = true
# while states_continue_flag == true
#   puts "Enter 'e' to add the edges"
#   puts "Enter the number of the state comma true/false if is an acceptance state Ex: 'a, true'"  
#   states_string = $stdin.readline().split(',')
#   if states_string != ["e\n"]
#     states << Ed::State.new(states_string.first, states_string[1].gsub("\n","").to_bool)
#   else
#     states_continue_flag = false
#   end
# end

# states.each do |state|
#   continue_flag = true
#   state.edges = []
#   while continue_flag == true
#     states.each_with_index { |state, i | puts "#{i} - #{state.name.upcase}"}
#     puts "Enter 'e' to add the exit"
#     puts "State: #{state.name.upcase}"
#     puts "Enter the edge's 'alphabet letter (0,1)' and the 'destination state' using the index in the menu. Ex[0, 3]"
#     edges_string = $stdin.readline().split(',')
#     if edges_string != ["e\n"]
#       edge = Ed::Edge.new(edges_string[0], states[edges_string[1].to_i])
#       puts "Adding edge to state: #{state.name}"
#       state.edges << edge
#     else
#       continue_flag = false
#     end
#   end
# end



# ----------------------------------------------
# This is to test an example without using the menu
# ----------------------------------------------
a_state = Ed::State.new("a", true)
b_state = Ed::State.new("b", true)
c_state = Ed::State.new("c", true)
d_state = Ed::State.new("d", false)

a_edge1 = Ed::Edge.new("0", a_state)
a_edge2 = Ed::Edge.new("1", b_state)
a_state.edges = [a_edge1, a_edge2]

b_edge1 = Ed::Edge.new("0", a_state)
b_edge2 = Ed::Edge.new("1", c_state)
b_state.edges = [b_edge1, b_edge2]

c_edge1 = Ed::Edge.new("0", a_state)
c_edge2 = Ed::Edge.new("1", d_state)
c_state.edges = [c_edge1, c_edge2]

d_edge1 = Ed::Edge.new("0", d_state)
d_edge2 = Ed::Edge.new("1", d_state)
d_state.edges = [d_edge1, d_edge2]

states = [a_state, b_state, c_state, d_state]
# ----------------------------------------------
# ----------------------------------------------



valid = []
invalid = []
rand(10000).to_s(2)
initial_time = Time.now
end_time = initial_time + 3*60  

while Time.now < end_time do
  random = rand(100).to_s(2)
  automata = Ed::Automata.new states, ["0", "1"]
  if automata.valid? random
    valid << random
  else
    invalid << random
  end
  system("clear")
  puts "Valid: #{valid.count}"
  puts "Invalid: #{invalid.count}"
end




