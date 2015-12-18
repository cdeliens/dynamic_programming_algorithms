module Ed
  class Node
    attr_accessor :distance, :name
    def initialize(n)
      @name = n
    end
  end

  class Edge
    attr_accessor :source, :destination, :weight
    def initialize(source,destination,weight)
      @source = source
      @destination = destination
      @weight = weight
    end
    
  end

  class BellmanFord

    def self.initialize_source_node(nodes, initial)
      nodes.each do |node|
        node.distance = Float::INFINITY
      end
      initial.distance = 0
    end

    def self.run(nodes, edges, initial)
      self.initialize_source_node(nodes, initial)
      for i in 0..nodes.size
        edges.each do |edge|
          if edge.destination.distance > edge.source.distance + edge.weight
            edge.destination.distance = edge.source.distance + edge.weight
          end
        end
      end
    end
  end

end

nodes = []
edges = []

puts "Enter the nodes separated by comma. The first one will be the initial node. Ex: a,b,c,d"
nodes_string = $stdin.readline().split(',')
nodes_string.each do |node|
  nodes << Ed::Node.new(node)
end

nodes.each do |node|
  nodes.each do |sub_node|
    puts "Enter the edge weight from #{node.name.upcase} to #{sub_node.name.upcase} if there is no connection use the letter i"
    weight = $stdin.readline()
    if weight != "i\n"
      edges << Ed::Edge.new(node,sub_node,weight.to_i) 
    end
  end
end

Ed::BellmanFord::run(nodes, edges, nodes.first)
system("clear")
puts "Result:"
nodes.each {|v| puts "From #{nodes.first.name.upcase} to #{v.name.upcase} the distance is #{v.distance}"}
