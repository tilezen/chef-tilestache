#!/usr/bin/env rake

desc "Run integration tests: foodcritic, rubocop, rspec"
task :travis do
  sandbox = File.join(File.dirname(__FILE__), %w{tmp foodcritic cookbook})
  prepare_sandbox(sandbox)

  # Fail the build only for correctness
  #
  puts "Running foodcritic..."
  sh "foodcritic --chef-version 11.10 --epic-fail correctness #{File.dirname(sandbox)}"

  # Check ruby syntax
  #
  puts "Running rubocop..."
  sh "rubocop #{File.dirname(sandbox)}"

  # Run specs
  #
  puts "Running rspec..."
  sh "rspec #{File.dirname(sandbox)}"
end

task default: 'travis'

private

def prepare_sandbox(sandbox)
  files = %w(*.md *.rb attributes definitions files libraries providers recipes resources spec templates)

  rm_rf sandbox
  mkdir_p sandbox
  cp_r Dir.glob("{#{files.join(',')}}"), sandbox
  puts "\n\n"
end
