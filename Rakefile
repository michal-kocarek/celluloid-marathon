require 'bundler/gem_tasks'

task default: :test

require 'rake/testtask'

test_files = FileList['test/**/*_test.rb']

Rake::TestTask.new(:test) do |test|
  test.libs << 'test'
  test.test_files = test_files
  test.verbose = true
end

