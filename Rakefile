# frozen_string_literal: true

# Include the 'spec' task provided by RSpec. If RSpec is not available, define
# a 'spec' task to show an appropriate message.
begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  task :spec do
    $stderr.puts "Failed to load RSpec. Please run: $ bundle install"
  end
end

task :default => :spec
