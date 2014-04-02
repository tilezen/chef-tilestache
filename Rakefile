#!/usr/bin/env rake

require 'rainbow/ext/string'

desc "Run integration tests: foodcritic, rubocop, rspec"
task :travis do
  # fail the build only for correctness
  #
  puts "\nRunning foodcritic".color(:blue)
  sh "foodcritic --chef-version 11.10 --epic-fail correctness ."

  # check ruby syntax
  #
  puts "Running rubocop".color(:blue)
  sh 'rubocop'

  # run specs
  #
  puts "\nRunning rspec".color(:blue)
  sh 'rspec'
end

task default: 'travis'
