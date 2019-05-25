require "byebug"

class HashSet
  attr_reader :store
  attr_accessor :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    x = num.hash
    unless include?(num)
      self[x] << x
      self.count += 1
      self.resize?
    end
  end
  
  def remove(num)
    #debugger
    x = num.hash
    if include?(num)
      @count -= 1
      self[x].delete(x)
    end
    
  end

  def include?(num)
    x = num.hash
    self[x].each do |check|
      return true if check == x
    end
    false
  end

  def resize?
    resize! if num_buckets == count
  end

  #private

  def [](num)
    store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = store.flatten
    self.count = 0
    @store = Array.new(num_buckets * 2) { Array.new }
    new_store.each do |single|
      insert(single)
    end 
  end
end

h = HashSet.new
p h
puts
h.insert(1)
p h
puts
p h[1]

puts 
p h.remove(1)
