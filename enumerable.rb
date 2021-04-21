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
    for i in self
        new_arr << i if yield(i) == true
    end
    new_arr
  end
end

p [2,4,3,5,43].my_select {|v| v.even? }

# {"three"=>"one", "four"=> "two", "one"=> "three"}.my_each_with_index { |(k,v), i | puts "#{k} : #{v} has index #{i}"}