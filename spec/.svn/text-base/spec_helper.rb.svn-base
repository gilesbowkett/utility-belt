# Make sure Rubygems' mangling of the path is already done before we do our own
# mangling.
require 'rubygems'

# Ensure that when we require UtilityBelt libs they are from the files under
# test, NOT from the installed gem.
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), ".."))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
