module Enumerable
  def my_each(&block)
    each(&block)
  end

  def my_each_with_index
    each do |i|
      yield(i, index(i))
    end
  end
end

%w[a b c].my_each_with_index { |val, index| puts "index: #{index} for #{val}" }
