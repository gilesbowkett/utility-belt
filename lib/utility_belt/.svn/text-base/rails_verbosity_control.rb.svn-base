# Rails verbosity: http://weblog.jamisbuck.org/2007/1/8/watching-activerecord-do-it-s-thing
# Marcel said they toyed with making this the console default on core
class Object
  def log
    ActiveRecord::Base.clear_active_connections!
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end
end
