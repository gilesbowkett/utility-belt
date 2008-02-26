require 'tempfile'

# This module adds a method, #to_file, which dumps the contents of self into a
# temp file and then returns the path of that file.  This is particularly useful
# when calling out to shell commands which expect their input in the form of
# files.
#
# Example: use UNIX 'diff' to compare two objects:
#
#    >> a = ["foo", "bar", "baz"].join("\n")
#    => "foo\nbar\nbaz"
#    >> b = ["foo", "buz", "baz"].join("\n")
#    => "foo\nbuz\nbaz"
#    >> puts `diff #{a.to_file} #{b.to_file}`
#    2c2
#    < bar
#    ---
#    > buz
#    => nil
#
module ConvertableToFile
  def to_file
    path = nil
    Tempfile.open(object_id.to_s) do |tempfile|
      tempfile << self
      path = tempfile.path
    end
    path
  end
end

class Object
  include ConvertableToFile
end
