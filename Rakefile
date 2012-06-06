require 'rubygems'
require 'rspec/core/rake_task'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "grammoire"
  gem.homepage = "http://github.com/moonpxi/grammoire"
  gem.license = "MIT"
  gem.summary = %Q{A context-sensitive grammar library for producing randomised objects}
  gem.description = %Q{A context-sensitive grammar library for producing randomised objects}
  gem.email = "paulo.schneider@gmail.com"
  gem.authors = ["moonpxi"]
end
Jeweler::RubygemsDotOrgTasks.new

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = %w{--format s --color}
end

desc 'Run acceptance specs'
RSpec::Core::RakeTask.new do |t|
  t.name = :acceptance
  t.rspec_opts = %w{--format s --color}
  t.pattern = "acceptance_spec/**/*_spec.rb"
end

task :all_tests => [:acceptance, :spec]