Gem::Specification.new do |s| 
  s.name = "utility_belt"
  s.version = "1.0.7"
  s.author = "Giles Bowkett"
  s.email = "gilesb@gmail.com"
  s.homepage = "http://utilitybelt.rubyforge.org"
  s.rubyforge_project = "utility_belt"
  s.platform = Gem::Platform::RUBY
  s.summary = "A grab-bag of IRB power user madness."
  s.files = ["bin", "bin/amazon", "bin/google", "bin/pastie", "History.txt", "html", "html/andreas00.css", "html/authorship.html", "html/bg.gif", "html/front.jpg", "html/index.html", "html/menubg.gif", "html/menubg2.gif", "html/test.jpg", "html/usage.html", "lib", "lib/utility_belt", "lib/utility_belt/amazon_upload_shortcut.rb", "lib/utility_belt/clipboard.rb", "lib/utility_belt/command_history.rb", "lib/utility_belt/convertable_to_file.rb", "lib/utility_belt/equipper.rb", "lib/utility_belt/google.rb", "lib/utility_belt/hash_math.rb", "lib/utility_belt/interactive_editor.rb", "lib/utility_belt/irb_options.rb", "lib/utility_belt/irb_verbosity_control.rb", "lib/utility_belt/is_an.rb", "lib/utility_belt/language_greps.rb", "lib/utility_belt/not.rb", "lib/utility_belt/pastie.rb", "lib/utility_belt/pipe.rb", "lib/utility_belt/rails_finder_shortcut.rb", "lib/utility_belt/rails_verbosity_control.rb", "lib/utility_belt/string_to_proc.rb", "lib/utility_belt/symbol_to_proc.rb", "lib/utility_belt/wirble.rb", "lib/utility_belt/with.rb", "lib/utility_belt.rb", "Manifest.txt", "README", "spec", "spec/convertable_to_file_spec.rb", "spec/equipper_spec.rb", "spec/hash_math_spec.rb", "spec/interactive_editor_spec.rb", "spec/language_greps_spec.rb", "spec/pastie_spec.rb", "spec/pipe_spec.rb", "spec/spec_helper.rb", "spec/string_to_proc_spec.rb", "spec/utility_belt_spec.rb", "utility-belt.gemspec"]
  %w{amazon google pastie}.each do |command_line_utility|
    s.executables << command_line_utility
  end
  s.require_path = "lib"
  s.test_file = "spec/utility_belt_spec.rb"
  s.has_rdoc = true 
  s.extra_rdoc_files = ["README"]
  s.add_dependency("activesupport")
  s.add_dependency("wirble", ">= 0.1.2")
  s.add_dependency("aws-s3", ">= 0.4.0")
  s.add_dependency("Platform", ">= 0.4.0")
end 
