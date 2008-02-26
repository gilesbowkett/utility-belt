require File.join(File.dirname(__FILE__), "spec_helper")
require "lib/utility_belt/string_to_proc"
describe "String to Proc" do

  before(:all) do
    @one2five = 1..5
  end

  it "should handle simple arrow notation" do
    @one2five.map(&'x -> x + 1').should eql(@one2five.map { |x| x + 1 })
    @one2five.map(&'x -> x*x').should eql(@one2five.map { |x| x*x })
    @one2five.inject(&'x y -> x*y').should eql(@one2five.inject { |x,y| x*y })
    'x y -> x**y'.to_proc()[2,3].should eql(lambda { |x,y| x**y }[2,3])
    'y x -> x**y'.to_proc()[2,3].should eql(lambda { |y,x| x**y }[2,3])
  end

  it "should handle chained arrows" do
    'x -> y -> x**y'.to_proc()[2][3].should eql(lambda { |x| lambda { |y| x**y } }[2][3])
    'x -> y z -> y**(z-x)'.to_proc()[1][2,3].should eql(lambda { |x| lambda { |y,z| y**(z-x) } }[1][2,3])
  end

  it "should handle the default parameter" do
    @one2five.map(&'2**_/2').should eql(@one2five.map { |x| 2**x/2 })
    @one2five.select(&'_%2==0').should eql(@one2five.select { |x| x%2==0 })
  end

  it "should handle point-free notation" do
    @one2five.inject(&'*').should eql(@one2five.inject { |mem, var| mem * var })
    @one2five.select(&'>2').should eql(@one2five.select { |x| x>2 })
    @one2five.select(&'2<').should eql(@one2five.select { |x| 2<x })
    @one2five.map(&'2*').should eql(@one2five.map { |x| 2*x })
    (-3..3).map(&'.abs').should eql((-3..3).map { |x| x.abs })
  end

  it "should handle implied parameters as best it can" do
    @one2five.inject(&'x*y').should eql(@one2five.inject(&'*'))
    'x**y'.to_proc()[2,3].should eql(8)
    'y**x'.to_proc()[2,3].should eql(8)
  end

end
