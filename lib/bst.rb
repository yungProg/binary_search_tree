<<<<<<< HEAD
# frozen_string_literal: true

# Object representing a node
class Node
  attr_accessor :left, :right, :data

=======
class Node
  attr_accessor :data, :left, :right
>>>>>>> eb4ff9afe53fb63bde0958be20f2a76c7e788f58
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

<<<<<<< HEAD
# Object representing a balanced Binary Search Tree
class BinarySearchTree
  def initialize(arr)
    @arr = arr
=======
class Tree
  def initialize(arr)
    @arr = arr.uniq.sort
>>>>>>> eb4ff9afe53fb63bde0958be20f2a76c7e788f58
    @root = build_tree(@arr, 0, @arr.length - 1)
  end

  def build_tree(arr, start, last)
<<<<<<< HEAD
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
=======
    return nil if arr.empty?
    return nil if start > last
    mid = (start + last) / 2
    node = Node.new(arr[mid])
    node.left = build_tree(arr, start, mid - 1)
    node.right = build_tree(arr, mid + 1, last)

    node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end 
>>>>>>> eb4ff9afe53fb63bde0958be20f2a76c7e788f58
end
