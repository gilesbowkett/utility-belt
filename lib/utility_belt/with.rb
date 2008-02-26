# Object#with -- by Dan Yoder, dev.zeraweb.com -- this is something from Pascal
# and JavaScript. here's the use case.

# instead of:
#   some_object.do_x
#   some_object.do_y
#   some_object.do_z
#
# you can instead do:
#   with(some_object)
#     do_x
#     do_y
#     do_z
#   end

class Object
  def with(object, &block)
    object.instance_eval &block
  end
end

