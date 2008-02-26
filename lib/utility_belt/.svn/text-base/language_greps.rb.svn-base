# fix by Bob Hutchison:
class String
  unless public_method_defined? :blank?
    def blank?
      self !~ /\S/
    end
  end
end

# TODO: upgrade these to take either regexes or strings

# http://gilesbowkett.blogspot.com/2006/12/smalltalk-cleverness-translated-into.html
# http://gilesbowkett.com/blog_code_samples/122906_seaside_rails/controller.txt
class Object
  def grep_classes(search_term)
    classes = []
    ObjectSpace.each_object {|object| classes << object.name if object.is_a? Class and not object.name.blank?}
    classes.find_all {|klass| klass.downcase.include? search_term.downcase}
  end
end

# http://gilesbowkett.blogspot.com/2007/11/irb-what-was-that-method-again.html
class Object
  def grep_methods(search_term)
    methods.find_all {|method| method.downcase.include? search_term.downcase}
  end
end

