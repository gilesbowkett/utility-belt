require File.join(File.dirname(__FILE__), "spec_helper")
require 'rubygems'
gem 'rspec'
require 'spec'
Platform = Module.new unless Object.const_defined?('Platform')
Net = Module.new unless Object.const_defined?('Net')

require File.expand_path(File.join(File.dirname(__FILE__),'..','lib/utility_belt'))
UtilityBelt.equip(:pastie)
include UtilityBelt::Pastie
Clipboard = UtilityBelt::Clipboard unless Object.const_defined?('Clipboard')

describe "pastie being called" do

  before(:all) do
    Net::HTTP = mock('HTTP') unless Net.const_defined?('HTTP')
    URI = mock('URI') unless Object.const_defined?('URI')
    Clipboard = mock('clipboard') unless Object.const_defined?('Clipboard')
  end

  before(:each) do
    @page = mock('page')
    @page.stub!(:body).and_return('href="foo"')
    Net::HTTP.stub!(:post_form).and_return(@page)
    URI.stub!(:parse)
    Clipboard.stub!(:read)
    Clipboard.stub!(:write)
    Kernel.stub!(:system)
  end

  it "should be available in global namespace and not blow-up with default stub/mocking" do
    pastie
  end

  it "should uri-parse the pastie uri" do
    URI.should_receive(:parse).with("http://pastie.caboo.se/pastes/create")
    pastie
  end

  it "should pass the uri-parsed result into the post" do
    URI.should_receive(:parse).and_return('a_uri_object')
    Net::HTTP.should_receive(:post_form).with('a_uri_object', anything()).and_return(@page)
    pastie
  end

  it "should call system open on the pastie return" do
    @page.should_receive(:body).and_return('href="returned_url"')
    case Platform::IMPL
    when :macosx
      Kernel.should_receive(:system).with("open returned_url")
    when :mswin
      Kernel.should_receive(:system).with("start returned_url")
    end
    pastie
  end

  it "should write resulting url into the clipboard" do
    @page.should_receive(:body).and_return('href="returned_url"')
    Clipboard.should_receive(:write).with('returned_url')
    pastie
  end

  describe "with no parameter it uses the clipboard" do
    it "should read the clipboard" do
      Clipboard.should_receive(:read)
      pastie
    end

    it "should put the clipboard results in the post to pastie" do
      Clipboard.should_receive(:read).and_return('bar')
      Net::HTTP.should_receive(:post_form).with(anything(),{"paste_parser" => "ruby",
        "paste[authorization]" => "burger",
        "paste[body]" => 'bar'}).and_return(@page)
      pastie
    end
  end

 describe "with a parameter instead" do
   #TODO: windows/linux safer now, since no clipboard functionality?
    it "should not even read the clipboard" do
      Clipboard.should_not_receive(:read)
      pastie "baz"
    end

    it "should pass in the parameter instead" do
      Net::HTTP.should_receive(:post_form).with(anything(),{"paste_parser" => "ruby",
        "paste[authorization]" => "burger",
        "paste[body]" => 'baz'}).and_return(@page)
      pastie "baz"
    end
  end
end
