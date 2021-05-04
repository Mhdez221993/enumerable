require_relative '../enumerable.rb'

describe Enumerable do
    let(:arr) { [1,2,3,4] }

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
end