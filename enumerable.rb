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
    for i in self do
        yield(i)
    end
  end
end

[2,4,3,5,43].my_each_with_index {| v, i| puts "#{v} has index #{i}"}

{"three"=>"one", "four"=> "two", "one"=> "three"}.my_each_with_index { |(k,v), i | puts "#{k} : #{v} has index #{i}"}