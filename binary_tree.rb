class Node
  attr_accessor :value, :parent, :left, :right

  def initialize(value, parent = nil)
    @value = value
    @parent = parent
    @left = nil
    @right = nil
  end

end

class BinaryTree
  attr_accessor :root

  def initialize(arr)
    build_tree(arr)
  end

  def build_tree_sorted(arr)
    return nil if arr.empty?
    root = Node.new(arr[arr.length/2])
    root.left = build_tree_sorted(arr[0, arr.length/2])
    root.right = build_tree_sorted(arr[arr.length/2 + 1, arr.length/2])
    root
  end

  def insert(item, node, parent = nil)
    return Node.new(item, parent) if node.nil?
    node.left = insert(item, node.left, node) if item < node.value
    node.right = insert(item, node.right, node) if item >= node.value
    node #when the stack unwinds, the final return will be the outermost parent, which is the root node
  end

  def build_tree(arr)
    @root = Node.new(arr.shift)  #shift moves array down one index
    arr.each {|item| insert(item, @root)}
    @root
  end
end


class BinaryTree
  def breadth_first_search(value, node = @root, queue = [])
    if node.nil?
      return nil
    elsif node.value == value
      return node
    else
      queue << node.left if node.left != nil
      queue << node.right if node.right != nil
      breadth_first_search(value, queue.shift, queue)
    end
  end
end

class BinaryTree
  def depth_first_search(value, node = @root, stack = [])
    stack << node
    while !stack.empty?
      node = stack.pop
      if node.value == value
        return node
        break
      else
        stack << node.right if node.right != nil
        stack << node.left if node.left != nil
      end
    end
    #return nil if stack.empty?
  end
end

class BinaryTree
  def dfs_rec(value, node = @root)
    if node.value == value
      return node
    else
      response = dfs_rec(value, node.left) if node.left != nil
      response = dfs_rec(value, node.right) if node.right != nil and response.nil?
    end
    response
  end

end
