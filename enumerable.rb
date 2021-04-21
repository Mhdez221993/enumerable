module Enumerable
  def my_each
    for i in self do
        self.class == Array ? yield(i) : yield(i[0], i[1])
    end
  end

  def my_each_with_index
    for i in self do
        yield(i, self.index(i))
    end
  end

  def my_select
    for i in self do
        yield(i)
    end
  end
end
