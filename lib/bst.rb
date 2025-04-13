# frozen_string_literal: true

# Object representing a node
class Node
  attr_accessor :left, :right, :data

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

# Object representing a balanced Binary Search Tree
class BinarySearchTree
  def initialize(arr)
    @arr = arr
    @root = build_tree(@arr, 0, @arr.length - 1)
  end

  def build_tree(arr, start, last)
    return nil if start > last

    mid = (start + last) / 2
    tree_nodes = Node.new(arr[mid])
    tree_nodes.left = build_tree(arr, start, mid - 1)
    tree_nodes.right = build_tree(arr, mid + 1, last)
    tree_nodes
  end

  def pretty_print(node = @root, prefix = '', is_left = true) # rubocop:disable Style/OptionalBooleanParameter
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
