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

  def delete(data, current_node = @root)
    return nil if current_node.nil?

    if data < current_node.data
      current_node.left = delete(data, current_node.left)
    elsif data > current_node.data
      current_node.right = delete(data, current_node.right)
    else
      if current_node.left.nil? && current_node.right.nil?
        return nil
      end

      return current_node.right if current_node.left.nil?
       
      return current_node.left if current_node.right.nil?
      
      successor = find_min(current_node.right)
      current_node.data = successor.data
      current_node.right = delete(successor.data, current_node.right)
    end
    current_node
  end

  def find_min(node)
    current_node = node
    current_node = current_node.left while current_node.left

    current_node
  end

  def find(data, current_node = @root)
    return nil if current_node.nil?
    if data < current_node.data
      current_node = find(data, current_node.left)
    elsif data > current_node.data
      current_node = find(data, current_node.right)
    end
    current_node
  end

  def level_order_iterate
    current_node = @root
    return [] if current_node.nil? unless block_given?
    order = [] unless block_given? 
    queue = []
    queue << current_node
    while queue.any?
      visited_node = queue.shift
      if block_given?
        yield(visited_node)
      else
        order << visited_node.data
      end
      queue << visited_node.left if visited_node.left
      queue << visited_node.right if visited_node.right
    end
    order unless block_given?
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
