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
      return nil if current_node.left.nil? && current_node.right.nil?

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
    return [] if current_node.nil?

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

  def level_order_recursion(current_node = @root, queue = [current_node], arr = [], &block)
    return [] if current_node.nil?
    return [] if queue.empty?

    current_node = queue.shift
    queue << current_node.left if current_node.left
    queue << current_node.right if current_node.right

    if block_given?
      yield(current_node)  
      level_order_recursion(current_node, queue, &block)
    else
      arr << current_node.data
    end
    level_order_recursion(current_node, queue, arr)
    arr unless block_given?
  end

  def preorder(current_node = @root, arr = [], &block)
    # root > left > right
    return [] if current_node.nil?

    if block_given?
      yield(current_node)
      preorder(current_node.left, &block)
      preorder(current_node.right, &block)
    else
      arr << current_node.data
      preorder(current_node.left, arr)
      preorder(current_node.right, arr)
      arr
    end
  end

  def inorder(current_node = @root, arr = [], &block)
    # left > root > right

    return [] if current_node.nil?

    if block_given?
      inorder(current_node.left, &block)
      yield(current_node)
      inorder(current_node.right, &block)
    else
      inorder(current_node.left, arr)
      arr << current_node.data
      inorder(current_node.right, arr)
      arr
    end
  end

  def postorder(current_node = @root, arr = [], &block)
    # left > right > root

    return [] if current_node.nil?

    if block_given?
      postorder(current_node.left, &block)
      postorder(current_node.right, &block)
      yield(current_node)
    else
      postorder(current_node.left, arr)
      postorder(current_node.right, arr)
      arr << current_node.data
      arr
    end
  end

  def height(data)
    node = find(data)
    return nil if node.nil?

    find_node_height(node)
  end

  def find_node_height(current_node)
    return -1 if current_node.nil?

    left = find_node_height(current_node.left)
    right = find_node_height(current_node.right)
    [left, right].max + 1
  end

  def depth(data)
    node = find(data)
    return nil if node.nil?

    find_node_depth(node)
  end

  def find_node_depth(node, current_node = @root, node_depth = 0)
    return -1 if current_node.nil?
    return node_depth if node == current_node

    left = find_node_depth(node, current_node.left, node_depth + 1)
    return left unless left == -1

    find_node_depth(node, current_node.right, node_depth + 1)
  end

  def balanced?(current_node = @root)
    return -1 if current_node.nil?

    difference = find_node_height(current_node.left) - find_node_height(current_node.right)
    return false if difference.abs > 1

    balanced?(current_node.left)
    balanced?(current_node.right)
    true
  end

  def rebalance
    new_array = inorder(@root)
    @root = build_tree(new_array, 0, new_array.length - 1)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private :find_min, :find_node_height, :find_node_depth
end
