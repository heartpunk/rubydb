require "progress_bar"
require "etc"
require "parser/current"
require "pp"

files = Dir.glob("**/*.rb")
bar = ProgressBar.new(files.length)

files.map do |file|
  bar.increment!

  begin
    visited_nodes = Set.new
    ast = Parser::CurrentRuby::parse(File.read(file))
    nodes = [ast]
    while !nodes.empty? do
      node = nodes[-1]
      if visited_nodes.include?(node) || !node.respond_to?(:children)
        pp node.type, node.location.to_hash.to_a if node.respond_to?(:location)
        nodes.pop
      else
        nodes.concat(node.children.to_a)
        visited_nodes << node
      end
    end
  rescue Parser::SyntaxError
  end
end
