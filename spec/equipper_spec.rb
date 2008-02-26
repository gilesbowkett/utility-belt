require File.join(File.dirname(__FILE__), "spec_helper")
require 'lib/utility_belt/equipper'

# Mocks for the gadgets
UTILITY_BELT_IRB_STARTUP_PROCS = {}

module IRB
  def self.conf
    {}
  end
end

describe "UtilityBelt equipper" do

  ALL_GADGETS = UtilityBelt::Equipper::GADGETS
  DEFAULT_GADGETS = UtilityBelt::Equipper::DEFAULTS

  before(:all) do
    # I know, global variables are bad, but I can't get this to work otherwise
    Kernel.__send__(:alias_method, :old_require, :require)
    Kernel.__send__(:define_method, :require, proc {|library| $required_libs << library[13..-1] })
  end

  before(:each) do
    $required_libs = []
  end

  after(:each) do
    $required_libs = nil
  end

  after(:all) do
    Kernel.__send__(:alias_method, :require, :old_require)
  end

  it "should load all gadgets" do
    UtilityBelt.equip(:all)
    $required_libs.should == ALL_GADGETS
  end

  it "should load no gadgets" do
    UtilityBelt.equip(:none)
    $required_libs.should == []
  end

  it "should load all default gadegts" do
    UtilityBelt.equip(:defaults)
    $required_libs.should == DEFAULT_GADGETS
  end

  it "should load all gadgets except is_an" do
    UtilityBelt.equip(:all, :except => ['is_an'])
    $required_libs.should == ALL_GADGETS - ['is_an']
  end

  it "should load no gadgets except is_an" do
    UtilityBelt.equip(:none, :except => ['is_an'])
    $required_libs.should == ['is_an']
  end

  it "should accept a string for the except-param" do
    UtilityBelt.equip(:none, :except => 'is_an')
    $required_libs.should == ['is_an']
  end

  it "should accept a symbol for the except-param" do
    UtilityBelt.equip(:none, :except => :is_an)
    $required_libs.should == ['is_an']
  end
end
