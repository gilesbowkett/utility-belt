#!/usr/bin/env ruby
require File.join(File.dirname(__FILE__), "spec_helper")

require 'spec'
require 'irb'
require 'delegate'
require File.join(File.dirname(__FILE__), '..', 'lib', 'utility_belt', 'interactive_editor')

# Using SimpleDelegator allows us to replace the constants without triggering a
# "constant redefined" warning.
module StubPlatform
  ARCH = SimpleDelegator.new(:x86)
  OS   = SimpleDelegator.new(:unix)
  IMPL = SimpleDelegator.new(:linux)
end

# Sneak a stub Platform class into InteractiveEditor so that we don't have to
# override constants on the real Platform module
#
# P.S. This ugliness is why libraries should always prefer to expose methods
# over constants.
class InteractiveEditor
  Platform = StubPlatform
end

describe InteractiveEditor, "given no clues as to what editor to use" do
  before :each do
    ENV.delete("VISUAL")
    ENV.delete("EDITOR")
    Kernel.stub!(:test).and_return(false)
    File.stub!(:executable?).and_return(false)
  end

  it "should complain" do
    lambda do
      InteractiveEditor.sensible_editor
    end.should raise_error
  end
end

describe InteractiveEditor,
         "given a Mac OS X platform and no editor environment vars" do

  before :each do
    ENV.delete("VISUAL")
    ENV.delete("EDITOR")
    @old_impl = StubPlatform::IMPL.__getobj__
    StubPlatform::IMPL.__setobj__(:macosx)
  end

  after :each do
    StubPlatform::IMPL.__setobj__(@old_impl)
  end

  it "should use the OS X 'open' command as the default editor" do
    InteractiveEditor.sensible_editor.should == "open"
  end
end

# xdg-open is a facility from the freedesktop.org, available on some recent free
# desktop operating systems (like Ubuntu).  It uses the desktop environments
# filetype associations to determine what program to open a file in.
describe InteractiveEditor,
         "given a Linux OS and no environment vars" do

  before :each do
    ENV.delete("VISUAL")
    ENV.delete("EDITOR")
    @old_impl = StubPlatform::IMPL.__getobj__
    StubPlatform::OS.__setobj__(:linux)
    File.stub!(:executable?).and_return(true)
  end

  after :each do
    StubPlatform::IMPL.__setobj__(@old_impl)
  end

  it "should attempt to use 'xdg-open' command as the default editor" do
    File.should_receive(:executable?).
      with("/usr/bin/xdg-open").
      and_return(true)
    InteractiveEditor.sensible_editor.should == "/usr/bin/xdg-open"
  end
end

# /usr/bin/sensible-editor is a Debian-ism AFAIK
describe InteractiveEditor,
         "given the existence of /usr/bin/sensible-editor and no xdg-open" do
  it "should use /usr/bin/sensible-editor as the default editor" do
    File.should_receive(:executable?).
      with("/usr/bin/xdg-open").
      and_return(false)
    File.should_receive(:executable?).
      with("/usr/bin/sensible-editor").
      and_return(true)
    InteractiveEditor.sensible_editor.should == "/usr/bin/sensible-editor"
  end
end

describe InteractiveEditor, "given an EDITOR environment variable" do
  before :each do
    File.stub!(:executable?).and_return(true)
    ENV["EDITOR"] = "MY_EDITOR"
  end

  after :each do
    ENV.delete("EDITOR")
  end

  it "should use the EDITOR environment variable to determine a sensible editor" do
    InteractiveEditor.sensible_editor.should == "MY_EDITOR"
  end
end

describe InteractiveEditor, "given a VISUAL environment variable" do
  before :each do
    File.stub!(:executable?).and_return(true)
    ENV["EDITOR"] = "MY_EDITOR"
    ENV["VISUAL"] = "MY_VISUAL_EDITOR"
  end

  after :each do
    ENV.delete("EDITOR")
    ENV.delete("VISUAL")
  end

  it "should use the environment variable to determine a sensible editor" do
    InteractiveEditor.sensible_editor.should == "MY_VISUAL_EDITOR"
  end
end

describe InteractiveEditing, "(calling out to an external editor)" do
  before :each do
    @it          = Object.new
    @it.extend(InteractiveEditing)
    @editor      = stub("Editor", :edit_interactively => nil)
    @editor_path = stub("Editor Path")
    InteractiveEditor.stub!(:sensible_editor).and_return(@editor_path)
    InteractiveEditor.stub!(:new).and_return(@editor)
  end

  it "should use InteractiveEditor to determine default editor" do
    @it.edit_interactively
    IRB.conf[:interactive_editors][@editor_path].should equal(@editor)
  end
end
