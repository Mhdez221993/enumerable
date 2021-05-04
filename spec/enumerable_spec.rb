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
    end
end