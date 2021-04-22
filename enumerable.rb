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

  def my_any?(*args)
    if block_given? == false
      if args.empty?
        return !self.empty? ? self.my_each {|v| return true if v != nil} == false : false
      else
        return my_each { |v| return true if v.is_a? *args } == false if args[0].class == Class
        return my_each { |v| return true if v.match(args[0]) } == false if args[0].class == Regexp
        return my_each { |v| return true if v == args[0] } == false
      end
    else
      my_each { |v| return true if yield(v) } == false
    end
  end
end


# p [1,2,2].my_any?(5)
# p [1,2,2].any?(5)
# p '-----------------------------------'
# p [nil, nil].my_any?
# p [nil, nil].any?
# p '-----------------------------------'

# p ["some", "somithimes", "something"].my_any?(/s/)
# p ["some", "somithimes", "something"].any?(/s/)

# p '-----------------------------------'
# p %w[ant bear cat].my_any?(/t/)  
# p %w[ant bear cat].any?(/t/)  
# p '-----------------------------------'

# p [2,3,3].my_any?(3) 
# p [1,2,3].any?(3) 
# p '-----------------------------------'

# p [1, 2i, 3.14, 5, 's'].my_any?(Numeric) 
# p [1, 2i, 3.14].any?(Numeric) 
# p '-----------------------------------'

# p %w[ant bear cat].my_any? { |word| word.length >= 10 }
# p %w[ant bear cat].any? { |word| word.length >= 10 }
# p '-----------------------------------'

# p %w[ant bear cat].my_any? { |word| word.length >= 4 }
# p %w[ant bear cat].any? { |word| word.length >= 4 }
# p '-----------------------------------'

# p %w[ant bear cat].my_any? 
# p %w[ant bear cat].any? 
# p '-----------------------------------'

# p [ nil, true, 99].my_any?  
# p [nil, true, 99].any?  
# p '-----------------------------------'

# p [1,2,3].my_any?
# p [1,2,3].any?
