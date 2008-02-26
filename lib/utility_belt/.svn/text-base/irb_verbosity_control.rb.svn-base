# IRB verbosity: http://groups.google.com/group/ruby-talk-google/browse_thread/thread/9c1febbe05513dc0
module IRB 
  def self.result_format 
     conf[:PROMPT][conf[:PROMPT_MODE]][:RETURN] 
  end 
  def self.result_format=(str) 
     result_format.replace(str) 
  end 
  def self.show_results 
     self.result_format = "=> %s\n"
  end 
  def self.hide_results 
     self.result_format = '' 
  end 
end

class Object
  def verbose
    IRB.show_results
  end
  alias :v :verbose

  def quiet
    IRB.hide_results
  end
  alias :q :quiet

  alias :x :exit
end

