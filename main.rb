# frozen_string_literal: true

require_relative 'lib/bst'
arr = (Array.new(15) { rand(1..100) })
tree = Tree.new(arr)
p tree.balanced?
p tree.level_order_iterate
p tree.preorder
p tree.postorder
p tree.inorder
5.times do
  tree.insert(rand(100...500))
end
p tree.balanced?
tree.rebalance
p tree.balanced?
p tree.level_order_iterate
p tree.preorder
p tree.postorder
p tree.inorder
