#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__), "spec_helper")

require 'spec'
require 'irb'
require File.join(File.dirname(__FILE__), '..', 'lib', 'utility_belt', 'convertable_to_file')

describe ConvertableToFile do
  include ConvertableToFile

  before :each do
    @tempfile = stub("temp file", :<< => nil, :path => nil)
    Tempfile.stub!(:open).and_yield(@tempfile)
  end

  it "should create a temp file using object id as basename" do
    should_receive(:object_id).and_return(6789)
    Tempfile.should_receive(:open).with("6789").and_yield(@tempfile)
    to_file
  end

  it "should dump self to the opened temp file" do
    @tempfile.should_receive(:<<).with(self)
    to_file
  end

  it "should return the temp file path" do
    @tempfile.should_receive(:path).and_return("TEMP_PATH")
    to_file.should == "TEMP_PATH"
  end
end
