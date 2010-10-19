require "rubygems"
require "bundler"

Bundler.require :default, :development

$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib'))
$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '..'))

require 'puremvc-as3'

require 'sprout/test/sprout_test_case'
