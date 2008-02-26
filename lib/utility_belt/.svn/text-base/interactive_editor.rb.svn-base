# Giles Bowkett, Greg Brown, and several audience members from Giles' Ruby East presentation.
require 'tempfile'
class InteractiveEditor
  DEBIAN_SENSIBLE_EDITOR = "/usr/bin/sensible-editor"
  MACOSX_OPEN_CMD        = "open"
  XDG_OPEN               = "/usr/bin/xdg-open"

  def self.sensible_editor
    return ENV["VISUAL"] if ENV["VISUAL"]
    return ENV["EDITOR"] if ENV["EDITOR"]
    return MACOSX_OPEN_CMD if Platform::IMPL == :macosx
    if Platform::IMPL == :linux
      if File.executable?(XDG_OPEN)
        return XDG_OPEN
      end
      if File.executable?(DEBIAN_SENSIBLE_EDITOR)
        return DEBIAN_SENSIBLE_EDITOR
      end
    end
    raise "Could not determine what editor to use.  Please specify."
  end

  attr_accessor :editor
  def initialize(editor = :vim)
    @editor = editor.to_s
    if @editor == "mate"
      @editor = "mate -w"
    end
  end
  def edit_interactively
    unless @file
      @file = Tempfile.new("irb_tempfile")
    end
    system("#{@editor} #{@file.path}")
    Object.class_eval(`cat #{@file.path}`)
    rescue Exception => error
      puts error
  end
end

module InteractiveEditing
  def edit_interactively(editor = InteractiveEditor.sensible_editor)
    unless IRB.conf[:interactive_editors] && IRB.conf[:interactive_editors][editor]
      IRB.conf[:interactive_editors] ||= {}
      IRB.conf[:interactive_editors][editor] = InteractiveEditor.new(editor)
    end
    IRB.conf[:interactive_editors][editor].edit_interactively
  end
  
  def handling_jruby_bug(&block)
    if RUBY_PLATFORM =~ /java/
      puts "JRuby IRB has a bug which prevents successful IRB vi/emacs editing."
      puts "The JRuby team is aware of this and working on it."
      puts "(http://jira.codehaus.org/browse/JRUBY-2049)"
    else
      yield
    end
  end

  def vi
    handling_jruby_bug {edit_interactively(:vim)}
  end

  def mate
    edit_interactively(:mate)
  end

  # TODO: Hardcore Emacs users use emacsclient or gnuclient to open documents in
  # their existing sessions, rather than starting a brand new Emacs process.
  def emacs
    handling_jruby_bug {edit_interactively(:emacs)}
  end
end

# Since we only intend to use this from the IRB command line, I see no reason to
# extend the entire Object class with this module when we can just extend the
# IRB main object.
self.extend InteractiveEditing if Object.const_defined? :IRB
