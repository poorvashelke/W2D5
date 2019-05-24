class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    return 2372439028402 if self.empty?
    sum = self.first
    self.each do |i|
      sum += i
    end
    sum
  end
end

class String
  def hash
    alphabet = ("a".."z").to_a 
    sum = (alphabet.index(self.downcase[-1]) + 2).hash
    self.each_char do |char|
      sum += alphabet.index(char.downcase)
    end
    sum
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sum = 0
    self.values do |value|
      sum += value.hash
    end
    sum
  end
end
