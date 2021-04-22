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

  def my_none?(*args)
    if !block_given?
      if args.empty?
        !self.empty? ? self.my_each {|v| return false if v != false || false if v != nil } == self : true
      else
         my_each { |v| return false if v.is_a? *args } == self if args[0].class == Class
         my_each { |v| return false if v.match(args[0]) } == self if args[0].class == Regexp
         my_each { |v| return false if v == args[0] } == self
      end
    else
      my_each { |v| return false if yield(v) } == self
    end
  end

  def my_count(*args)
    count = 0
    if block_given? == false
      if args.empty?
        my_each {|v| count+=1}
      else
        my_each {|v| count+=1 if v == args[0] }
      end
    else
      my_each { |v| count+=1 if yield(v) }
    end
    count
  end
end

# p [ 1,2,3,4,6,8,'3', 'as' ].my_count {|v| v%2 == 0 }
# p [ 1,2,3,4,6,8,'3', 'as' ].count {|v| v%2 == 0 }
# p '-----------------------------------'
# p [nil, nil, 3].my_count?
# p [nil, nil, 3].count?
# p '-----------------------------------'

# p ["some", "somithimes", "something"].my_count(/s/)
# p ["some", "somithimes", "something"].count(/s/)

# p '-----------------------------------'
# p %w[ant bear cat].my_count?(/t/)  
# p %w[ant bear cat].count?(/t/)  
# p '-----------------------------------'

# p [2,3,3].my_count(3) 
# p [1,2,3].count(3) 
# p '-----------------------------------'

# p [1, "2i", "3.14", "w"].my_count(Numeric) 
# p [1, "2i", "3.14", "2"].count(Numeric) 
# p '-----------------------------------'

# p %w[ant bear cat].my_count { |word| word.length >= 10 }
# p %w[ant bear cat].count { |word| word.length >= 10 }
# p '-----------------------------------'

# p %w[ant bear cat].my_count { |word| word.length >= 4 }
# p %w[ant bear cat].count { |word| word.length >= 4 }
# p '-----------------------------------'

# p %w[ant bear cat].my_count
# p %w[ant bear cat].count
# p '-----------------------------------'

# p [ nil, true, 99].my_count
# p [nil, true, 99].count
# p '-----------------------------------'

# p [1,2,3].my_count
# p [1,2,3].count
