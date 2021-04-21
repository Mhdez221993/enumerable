module Enumerable
  def my_each
    for i in self do
        self.class == Array ? yield(i) : yield(i[0], i[1])
    end
  end

  def my_each_with_index
    for i in self do
      self.class == Array ? yield(i, self.index(i)) : yield([i[0], i[1]], self.keys.index(i[0]))
    end
  end

  def my_select
    new_arr = []
    new_hash = {}
    self.my_each do |k,v|
        if self.class == Array
            new_arr << k if yield(k) == true
        else
            new_hash.store(k,v) if yield(k,v) == true
        end
    end
    new_arr.empty? ? new_hash : new_arr
  end

  def my_all?(*args)
    if block_given?
      self.my_each do |e|
        return false if yield(e) == false
      end
    end
    if !block_given? 
      if self.index(nil)
        return !self.index(nil) ? true : false
      end  
      if !args.empty?
        if ( args[0].class != Regexp) && ( args[0].class != Class)
          return  false 
        end
        self.my_each do |e|
          if ( args[0].class == Regexp) &&(args[0].match(e.to_s)) == nil
            return false
          end
          if ( args[0].class == Class) && (e.is_a? args[0]) == false 
            return false
          end
        end
      end
    end
    return true
  end
end


# p [1, 5, 3.14].my_all?(5)
# p [1, 5, 3.14].all?(5)

# p [nil, nil, nil].my_all?
# p [nil, nil, nil].all?

# p ["some", "somithimes", "something"].my_all?(/s/)
# p ["some", "somithimes", "something"].all?(/s/)

# p %w[ant bear cat].my_all?(/t/)  
# p %w[ant bear cat].all?(/t/)  

# p %w[ant bear cat].my_all?(/a/) 
# p %w[ant bear cat].all?(/a/) 

# p [1, 2i, 3.14, 5].my_all?(Numeric) 
# p [1, 2i, 3.14, 5].all?(Numeric) 

# p %w[ant bear cat].my_all? { |word| word.length >= 3 }
# p %w[ant bear cat].all? { |word| word.length >= 3 }

# p %w[ant bear cat].my_all? { |word| word.length >= 4 }
# p %w[ant bear cat].all? { |word| word.length >= 4 }

# p %w[ant bear cat].my_all? 
# p %w[ant bear cat].all? 

# p [ nil, true, 99].my_all?  
# p [nil, true, 99].all?  

# p [].my_all?
# p [].all?
