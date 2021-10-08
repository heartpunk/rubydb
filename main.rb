require "progress_bar"
require "etc"
require "parser/current"
require "pp"

files = Dir.glob("**/*.rb")
bar = ProgressBar.new(files.length)

def ast_node? maybe_node
  has_children(maybe_node) && locatable?(:location)
end

def has_children? a
  a.respond_to? :location
end

def locatable? a
  a.respond_to? :location
end

files.map do |file|
  bar.increment!

  begin
    visited_nodes = Set.new
    ast = Parser::CurrentRuby::parse(File.read(file))
    nodes = [ast]
    while !nodes.empty? do
      node = nodes[-1]
      if visited_nodes.include?(node) || !has_children?(node)
        pp node.type, node.location.to_hash.to_a if locatable?(node)
        nodes.pop
      else
        nodes.concat(node.children.to_a)
        visited_nodes << node
      end
    end
  rescue Parser::SyntaxError
  end
end
