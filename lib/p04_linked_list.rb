class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    self.prev.next = self.next if self.prev
    self.next.prev = self.prev if self.next
    self.next = nil
    self.prev = nil
    self
  end
end

class LinkedList
  attr_reader :head, :tail
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    if self.empty?
      nil
    else
      self.head.next
    end
  end

  def last
    if self.empty?
      nil
    else
      self.tail.prev
    end
  end

  def empty?
    self.head.next == self.tail
    # self.head.next == nil
  end

  def get(key)
    self.each { |node| return node.val if node.key == key }
    nil
  end

  def include?(key)
    self.any? { |node| node.key == key }
  end

  def append(key, val)
    new_node = Node.new(key, val)

    unless empty?
      old_last_node = self.last
      old_last_node.next = new_node
      new_node.prev = old_last_node
      new_node.next = self.tail
      self.tail.prev = new_node
    else
      head.next = new_node
      new_node.prev = head
      new_node.next = self.tail
      self.tail.prev = new_node
    end
  end

  def update(key, val)
    self.each do |node|
      if node.key == key
        node.val = val
        return node
      end
    end
  end

  def remove(key)
    # return if empty?
    self.each do |node|
      if node.key == key
        node.remove
        return node.val
      end
    end
    nil
  end

  def each(&prc)
    # list_vals_ordered = self.values
    # self.each { |node| list_vals_yielded << node.val }
    # list_vals_yielded
    # list_vals_yielded = []

    curr_node = self.head.next
    until curr_node == self.tail
      prc.call(curr_node)
      curr_node = curr_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
