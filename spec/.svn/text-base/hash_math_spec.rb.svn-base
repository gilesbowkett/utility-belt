require File.join(File.dirname(__FILE__), "spec_helper")
require "lib/utility_belt/hash_math"
describe "Hash math" do

  it "should add hashes" do
    ({:a => :b} + {:c => :d}).should == {:a => :b, :c => :d}
  end

  it "should subtract hashes" do
    ({:a => :b, :c => :d} - {:c => :d}).should == {:a => :b}
  end

  it "should subtract key/value pairs by key" do
    ({:a => :b, :c => :d} - :c).should == {:a => :b}
  end

end
