# frozen_string_literal: true

# rubocop: disable Metrics/ModuleLength
# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

# module Enumerable
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < to_a.length
      instance_of?(Hash) ? yield([to_a[i][0], to_a[i][1]]) : yield(to_a[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < to_a.length
      instance_of?(Hash) ? yield([to_a[i][0], to_a[i][1]], i) : yield(to_a[i], i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    new_arr = []
    new_hash = {}
    my_each do |k, v|
      if instance_of?(Hash)
        new_hash.store(k, v)
      elsif yield(k, v) == true
        new_arr << k if yield(k) == true
      end
    end
    new_arr.empty? ? new_hash : new_arr
  end

  def my_all?(*args)
    if block_given?
      my_each do |e|
        return false if yield(e) == false
      end
    end
    unless block_given?
      if index(nil)
        return !index(nil) ? true : false
      end
      if index(false)
        return !index(false) ? true : false
      end

      unless args.empty?

        my_each do |e|
          return false if args[0].instance_of?(Regexp) && args[0].match(e.to_s).nil?
          return false if args[0].instance_of?(Class) && (e.is_a? args[0]) == false
          return false if !args[0].instance_of?(Regexp) && !args[0].instance_of?(Class) && args[0] != e
        end
      end
    end
    true
  end

  def my_any?(*args)
    if block_given? == false
      if args.empty?
        !empty? ? my_each { |v| return true unless v.nil? || v == false } == false : false
      else
        return my_each { |v| return true if v.is_a?(*args) } == false if args[0].instance_of?(Class)
        return my_each { |v| return true if v.match(args[0]) } == false if args[0].instance_of?(Regexp)

        my_each { |v| return true if v == args[0] } == false
      end
    else
      my_each { |v| return true if yield(v) } == false
    end
  end

  def my_none?(*args)
    if !block_given?
      if args.empty?
        if !empty?
          my_each do |v|
            return false unless v.nil? || (v == false)
          end == self
        else
          true
        end
      else
        my_each { |v| return false if v.is_a?(*args) } == self if args[0].instance_of?(Class)
        my_each { |v| return false if v.match(args[0]) } == self if args[0].instance_of?(Regexp)
        my_each { |v| return false if v == args[0] } == self
      end
    else
      my_each { |v| return false if yield(v) } == self
    end
  end

  def my_count(*args)
    count = 0
    if block_given? == false
      args.empty? ? my_each { |_v| count += 1 } : my_each { |v| count += 1 if v == args[0] }
    else
      my_each { |v| count += 1 if yield(v) }
    end
    count
  end

  def my_map(&proc)
    return to_enum(:my_map) unless block_given?

    array = []
    to_a.my_each { |v| array << proc.call(v) }
    array
  end

  def my_inject(*args)
    if block_given? == false
      raise LocalJumpError, 'no block given' if args.empty?
      accu = args.size < 2 ? to_a[0] : args[0]
      to_a.my_each_with_index do |_v, i|
        accu = accu.send(args[0], to_a[i + 1]) if args.size < (2) && !to_a[i + 1].nil?
        accu = accu.send(args[1], to_a[i]) if args.size >= 2
      end
    else
      accu = args.empty? ? to_a[0] : args[0]
      my_each_with_index { |_v, i| accu = yield(accu, to_a[i + 1]) unless to_a[i + 1].nil? } if args.empty?
      my_each_with_index { |_v, i| accu = yield(accu, to_a[i]) } unless args.empty?
    end
    accu
  end
end

def multiply_els(array)
  array.my_inject { |product, i| product * i }
end

# rubocop: enable Metrics/ModuleLength
# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
