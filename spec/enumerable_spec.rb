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
end