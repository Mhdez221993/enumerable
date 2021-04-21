module Enumerable
  def my_each
    for i in self do
        yield(i)
    end
  end
end

[ "a", "b", "c" ].my_each {|x| print x, " -- " }
