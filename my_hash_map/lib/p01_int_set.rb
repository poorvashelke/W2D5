class MaxIntSet
  attr_reader :store
  def initialize(max)
    @store = Array.new(max) { false }
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)

    store[num] = true
  end

  def remove(num)
    raise "Out of bounds" unless is_valid?(num)

    store[num] = false
  end

  def include?(num)
    store[num]
  end

  private

  def is_valid?(num)
    return false if num > store.length || num < 0

    true
  end

  def validate!(num)
  end
end


class IntSet
  attr_reader :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num 
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].each do |check|
      return true if check == num
    end
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    store[num % store.length]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :store
  attr_accessor :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)

    unless include?(num)
      self[num] << num
      self.count += 1
      self.resize?
    end
  end

  def remove(num)
    if include?(num)
      @count -= 1
      self[num].delete(num)
    end
    
  end

  def include?(num)
    self[num].each do |check|
      return true if check == num
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
