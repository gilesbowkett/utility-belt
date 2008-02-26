# http://www.clarkware.com/cgi/blosxom/2007/09/03#ConsoleFindShortcut
# Mike Clark's find() shortcut for Rails console

# Creates shortcut methods for finding models.
UTILITY_BELT_IRB_STARTUP_PROCS[:define_model_find_shortcuts] = lambda do
  if defined? ActiveRecord::Base || defined? ActiveResource::Base
    model_files = Dir.glob("app/models/**/*.rb")
    table_names = model_files.map { |f| File.basename(f).split('.')[0..-2].join }
    table_names.each do |table_name|
      Object.instance_eval do
        define_method(table_name) do |*args|
          table_name.camelize.constantize.send(:find, *args)
        end
      end
    end
  end
end
# note: Mike wrote this for ARec, but it works on ARes too since it doesn't hit the DB
