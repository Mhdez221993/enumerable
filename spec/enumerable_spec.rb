# frozen_string_literal: true

require_relative '../enumerable'
describe Enumerable do
  let(:arr) { [1, 2, 3, 4] }
  let(:hash) { { '1' => 'January', '2' => 'February' } }
  let(:array_nil) { [nil, 1, 2, 3] }
  let(:array_false) { [false, 1, 2, 3] }
  let(:array_false_and_nil) { [false, nil, false, nil] }

  describe '#my_each' do
    it 'return the enumerable' do
      expect(arr.my_each).to be_a(Enumerator)
    end

    it 'return the same array' do
      expect(arr.my_each { |v| v + 1 }).to eq arr
    end

    it 'Iterate over the array and update a new one' do
      new_arr = []
      arr.my_each { |v| new_arr << v + 1 }
      expect(new_arr).to eq([2, 3, 4, 5])
    end
  end

  describe '#my_each_with_index' do
    it 'return the enumerable' do
      expect(arr.my_each_with_index).to be_a(Enumerator)
    end

    it 'return the same array' do
      expect(arr.my_each_with_index { |v, _i| v + 1 }).to eq arr
    end

    it 'Iterate over the array and update a new one' do
      new_arr = []
      arr.my_each_with_index { |v, _i| new_arr << v + 1 }
      expect(new_arr).to eq([2, 3, 4, 5])
    end
  end

  describe '#my_select' do
    it 'return the enumerable' do
      expect(arr.my_select).to be_a(Enumerator)
    end

    it 'Iterate over the array and update a new one' do
      new_arr = []
      arr.my_select { |v| new_arr << v if v > 3 }
      expect(new_arr).to eq([4])
    end

    it 'return january' do
      expect(hash.my_select { |v| v == '1' }).to eq({ '1' => 'January' })
    end
  end

  describe '#my_all?' do
    it 'return true when ther is no nil or false value' do
      expect(arr.my_all?).to eq true
    end

    it 'return false when ther is one nil value' do
      expect(array_nil.my_all?).to eq false
    end

    it 'return false when ther is one false value' do
      expect(array_false.my_all?).to eq false
    end

    it 'return true when all values satisfy the condition' do
      expect(arr.my_all? { |v| v > 0 }).to eq true
    end

    it 'return true when all values are instance of class' do
      expect(arr.my_all?(Numeric)).to eq true
    end

    it 'return false when a value is different from the argument' do
      expect(arr.my_all?(1)).to eq false
    end

    it 'return true when all values match with  the regex' do
      expect(arr.my_all?(/[0-9]/)).to eq true
    end
  end

  describe '#my_any' do
    it 'return true if find one value different then nil' do
      expect(array_nil.my_any?).to eq true
    end

    it 'return true if find one value different then false' do
      expect(array_false.my_any?).to eq true
    end

    it 'return false if all values are nil or false' do
      expect(array_false_and_nil.my_any?).to eq false
    end

    it 'return true if one value satisfy the contidion' do
      expect(arr.my_any?(Numeric)).to eq true
    end

    it 'return true when all values match with  the regex' do
      expect(arr.my_any?(/[0-9]/)).to eq true
    end

    it 'return true if one value satisfy the contidion' do
      expect(arr.my_any? { |v| v > 3 }).to eq true
    end
  end

  describe '#my_none?' do
    it 'return false if find one value different then nil' do
      expect(array_nil.my_none?).to eq false
    end

    it 'return false if find one value different then false' do
      expect(array_false.my_none?).to eq false
    end

    it 'return true if all the values are false or nil' do
      expect(array_false_and_nil.my_none?).to eq true
    end

    it 'return false if find one value instance of class' do
      expect(array_false.my_none?(Numeric)).to eq false
    end

    it 'return false if find one value match with regex' do
      expect(arr.my_none?(/[0-9]/)).to eq false
    end

    it 'return false if find one value satisfy the condition' do
      expect(arr.my_none? { |v| v > 0 }).to eq false
    end
  end

  describe '#my_count' do
    it 'if no paramether given it count all the values' do
      expect(arr.my_count).to eq 4
    end

    it 'if paramether given it count how many times is included' do
      expect(arr.my_count(3)).to eq 1
    end

    it 'count the elements that sitisfy the contition' do
      expect(arr.my_count { |v| v > 1 }).to eq 3
    end
  end

  describe '#my_map' do
    it 'return the enumerable if no block given' do
      expect(arr.my_map).to be_a(Enumerator)
    end

    it 'return a new array if block given' do
      expect(arr.my_map { |v| v + 1 }).to eq([2, 3, 4, 5])
    end

    it 'return a new array if proc is given' do
      expect(arr.my_map(&:to_s)).to eq(%w[1 2 3 4])
    end

    it 'return a new array if proc is given' do
      expect(arr.my_map(proc { |v| v.to_s }) { |v| v + 1 }).to eq(%w[1 2 3 4])
    end
  end

  describe '#my_inject' do
    it 'no block and proc raise error' do
      expect { arr.my_inject }.to raise_error
    end

    it 'if simbol given it execute the operatin' do
      expect(arr.my_inject(:+)).to eq 10
    end

    it 'if simbol and integer given it execute the operatin with the integer as started value' do
      expect(arr.my_inject(2, :+)).to eq 12
    end

    it 'takes a block a execute the condition given' do
      expect(arr.my_inject { |a, v| a * v }).to eq 24
    end

    it 'takes argument as accumulator an execute it in the block' do
      expect(arr.my_inject(2) { |a, v| a * v }).to eq 48
    end
  end

  describe '#multiply_els' do
    it 'return the multiplication of all the values' do
      expect(multiply_els(arr)).to eq(24)
    end
  end
end
