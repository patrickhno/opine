source "http://rubygems.org"

if RUBY_PLATFORM =~ /darwin/
  gem 'cocoa' #, :path => '../cocoa'
end
gem 'cairo' #, :path => '../rcairo'

group :development do
  gem 'opine', :path => '.' unless File.basename($0) == 'rake' && $*.first == 'gemspec'
  gem 'sqlite3'
  gem 'activerecord', '~> 4.0.4'
  gem 'activesupport', '~> 4.0.4'

  gem 'bacon'
  # gem "shoulda", ">= 0"
  gem "rdoc", "~> 3.12"
  gem "bundler", "~> 1.0"
  gem "jeweler", "~> 2.0.1"
  gem "simplecov", ">= 0"
end
