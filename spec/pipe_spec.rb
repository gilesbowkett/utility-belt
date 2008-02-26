#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__), "spec_helper")

require 'spec'
require 'irb'
require File.join(File.dirname(__FILE__), '..', 'lib', 'utility_belt', 'pipe')

describe "String#|" do
  before :each do
    @pipe = stub(:pipe, :write => nil, :close_write => nil, :read => nil)
    IO.stub!(:popen).and_yield(@pipe).and_return("RESULT")
  end

  it "should open a pipe" do
    IO.should_receive(:popen).with("COMMAND", 'r+').and_return(@pipe)
    "foo" | "COMMAND"
  end

  it "should write itself to the the pipe, close it, then read from it" do
    @pipe.should_receive(:write).with("foo").ordered
    @pipe.should_receive(:close_write).ordered
    @pipe.should_receive(:read)

    "foo" | "COMMAND"
  end

  it "should return the result of the IO.popen block" do
    ("foo" | "COMMAND").should == "RESULT"
  end
end
