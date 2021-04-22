# rubocop: disable Metrics/ModuleLength
# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

module Enumerable
  def my_each
    return self.to_enum(:my_each) unless block_given?

    for i in self do
        self.class == Array ? yield(i) : yield(i[0], i[1])
    end
  end

  def my_each_with_index
    return self.to_enum(:my_each_with_index) unless block_given?

    for i in self do
      self.class == Array ? yield(i, self.index(i)) : yield([i[0], i[1]], self.keys.index(i[0]))
    end
  end

  def my_select
    return self.to_enum(:my_select) unless block_given?
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

  def my_map(*args)
    return self.to_enum(:my_map) unless block_given?

    array = []
    self.to_a.my_each { |v|  array << yield(v)}
    array
  end

  def my_inject(*args)
    if block_given? == false
      args.size < 2 ? accu = self.to_a[0] : accu = args[0]
      self.to_a.my_each_with_index do |v,i|
        if args.size < 2
          break if self.to_a[i+1] == nil
          accu = eval "#{accu} #{args[0]} #{self.to_a[i+1]}"
        else
          accu = eval "#{accu} #{args[1]} #{self.to_a[i]}"
        end
      end
      return accu
    else
      if args.empty?
        i = 0
        accu = self.to_a[0]
        while i < self.to_a.length-1 || self.to_a[i+1] != nil
          accu = yield(accu, self.to_a[i+1])
          i+=1
        end
        return accu
      else
        i = 0
        accu = args[0]
        while i < self.to_a.length
          accu = yield(accu, self.to_a[i])
          i+=1
        end
        return accu
      end
    end
  end

end

def multiply_els(args)
  args.my_inject(:*)
end

# rubocop: disable Metrics/ModuleLength
# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
