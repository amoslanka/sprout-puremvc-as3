# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
# require 'rake'
require 'puremvc-as3/version'

# require "sprout-papervision/version"

Gem::Specification.new do |s|
  s.name        = PureMVC_AS3::NAME
  s.version     = PureMVC_AS3::VERSION
  # s.platform    = Gem::Platform::RUBY
  # s.authors     = ["TODO: Write your name"]
  s.email       = ["amoslanka@gmail.com"]
  s.homepage    = "http://www.github.com/amoslanka/sprout-puremvc-as3"
  s.summary     = %q{The ActionScript 3 port of PureMVC wrapped in a Sprout::Specification for implementation into a sprout project and Gem::Specification for distribution as a gem.}
  # s.description = %q{TODO: Write a gem description}

  # s.files         = `git ls-files`.split("\n")
  # s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.executables = ['puremvc-as3']
  s.require_paths << 'lib'
  
  # s.files should not use FileList (to reduce unneeded depencency on rake)
  s.files = Dir.glob ["{bin,lib,test}/**/*"]
  s.files.concat Dir.glob ["README*", "Gemfile*", "Rakefile*", "*.gemspec"]
  
  s.add_dependency "flashsdk", '>= 1.0.8.pre'
  s.add_development_dependency "shoulda"
  s.add_development_dependency "mocha"
  s.add_development_dependency "rcov"
  s.add_development_dependency "rake"
  
end
