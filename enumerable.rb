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
end

p [2,4,3,5,43].my_select {|v| v.even? }

stock = {
    apples: '10',
    oranges: 'key-value',
    bananas: 1
}

p stock.my_select { |k,v| v == 'key-value' }


# h = {} h.merge!(key: "bar") # => {:key=>"bar"} 