require_relative '../enumerable.rb'

describe Enumerable do
    let(:arr) { [1,2,3,4] }
    let(:hash) { {"1" => "January", "2" => "February"} }

    describe "#my_each" do
       it "return the enumerable" do
           expect(arr.my_each).to be_a(Enumerator)
       end

       it "return the same array" do
            expect(arr.my_each {|v| v+1}).to eq arr
       end

       it "Iterate over the array and update a new one" do
        new_arr = []
        arr.my_each{|v| new_arr << v+1}
        expect(new_arr).to eq([2,3,4,5]) 
   end
    end

    describe "#my_each_with_index" do
        it "return the enumerable" do
            expect(arr.my_each_with_index).to be_a(Enumerator)
        end
 
        it "return the same array" do
             expect(arr.my_each_with_index {|v, i| v+1}).to eq arr
        end

        it "Iterate over the array and update a new one" do
            new_arr = []
            arr.my_each_with_index {|v, i| new_arr << v+1}
            expect(new_arr).to eq([2,3,4,5]) 
       end
    end

    describe "#my_select" do
        it "return the enumerable" do
            expect(arr.my_select).to be_a(Enumerator)
        end

        it "Iterate over the array and update a new one" do
            new_arr = []
            arr.my_select {|v| new_arr << v if v > 3}
            expect(new_arr).to eq([4]) 
       end

       it "return january" do
            expect(hash.my_select {|v| v == '1'}).to eq({"1" => 'January'})
      end
    end

    describe "#my_all?" do
        it "return true when ther is no nil or false value" do
            expect(arr.my_all?).to eq true
        end

        it "return false when ther is one nil value" do
            array = [nil,1,2,3]
            expect(array.my_all?).to eq false
        end

        it "return false when ther is one false value" do
            array = [false,1,2,3]
            expect(array.my_all?).to eq false
        end

        it "return true when all values satisfy the condition" do
            expect(arr.my_all? {|v| v > 0}).to eq true
        end

        it "return true when all values are instance of class" do
            expect(arr.my_all?(Numeric)).to eq true
        end

        it "return false when a value is different from the argument" do
            expect(arr.my_all?(1)).to eq false
        end

        it "return true when all values match with  the regex" do
            expect(arr.my_all?(/[0-9]/)).to eq true
        end


    end
end