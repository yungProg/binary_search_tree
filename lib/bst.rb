# frozen_string_literal: true

# Object representing a node
class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

# Object representing a BST
class Tree
  def initialize(arr)
    @arr = arr.uniq.sort
    @root = build_tree(@arr, 0, @arr.length - 1)
  end

  def build_tree(arr, start, last)
    return nil if arr.empty?
    return nil if start > last

    mid = (start + last) / 2
    node = Node.new(arr[mid])
    node.left = build_tree(arr, start, mid - 1)
    node.right = build_tree(arr, mid + 1, last)

    node
  end

  def insert(data, current_node = @root)
    return Node.new(data) if current_node.nil?
    return current_node if data == current_node.data

    if data < current_node.data
      current_node.left = insert(data, current_node.left)
    elsif data > current_node.data
      current_node.right = insert(data, current_node.right)
    end
    current_node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
