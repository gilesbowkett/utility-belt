#!/usr/bin/env ruby
%w{rubygems platform cgi}.each {|library| require library}

UtilityBelt.equip(:clipboard)

module UtilityBelt
  module Google
    def google(search_term = nil)
      search_term ||= Clipboard.read if Clipboard.available?
      if search_term.empty?
        puts "Usage: google search_term_without_spaces           (Unix command line only)"
        puts "       google 'search term with spaces'            (Unix or IRB)"
        puts "       google                                      (Unix or IRB)"
        puts "              (if invoking without args, must have text in clipboard)"
      else
        url = "http://google.com/search?q=#{CGI.escape(search_term)}"
        case Platform::IMPL
        when :macosx
          Kernel.system("open #{url}")
        when :windows
          Kernel.system("start #{url}")
        #when :linux
        else
          puts "Sorry, don't know how to open an URL from the command line on your platform"
        end
      end
    end
  end
end

class Object
  include UtilityBelt::Google
end if Object.const_defined? :IRB
