require File.join(File.dirname(__FILE__), "spec_helper")
require "lib/utility_belt/array_numberings"
describe "Array Numberings" do
	
	before do
		@the_methods = {
			:second  => 1,
			:third   => 2,
			:fourth  => 3,
			:fifth   => 4,
			:sixth   => 5,
			:seventh => 6,
			:eighth  => 7,
			:ninth   => 8,
			:tenth   => 9
		}
	end
	
  it "should add array numberings" do
	
		@the_methods.keys do | method_name |
			Array.new.respond_to?(method_name).should == true
		end
		
  end

	it "should return the right value from each numbering" do
		
		array = (0..10).to_a
		
		@the_methods.each_pair do | method_name, index |
			array.send(method_name).should == array[index]
		end
		
	end

end
