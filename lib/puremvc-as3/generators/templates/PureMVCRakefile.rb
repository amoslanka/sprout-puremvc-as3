require 'bundler'
Bundler.require

library 'puremvc-as3', :swc
# library 'puremvc-as3', :asdocs

##############################
# Configure

def configure_mxmlc t
  t.library_path << 'lib/puremvc-as3/'
end

##############################
# Debug

# Compile the debug swf
mxmlc "<%= bin %>/<%= debug_swf_name %>" do |t|
  configure_mxmlc t
  t.input = "<%= src %>/<%= class_name %>.as"
  t.debug = true
end

desc "Compile and run the debug swf"
flashplayer :debug => "<%= bin %>/<%= debug_swf_name %>"

##############################
# Test

library :asunit4

# Compile the test swf
mxmlc "<%= bin %>/<%= test_swf_name %>" => :asunit4 do |t|
  configure_mxmlc t
  t.input = "<%= src %>/<%= test_runner_name %>.as"
  t.library_path << "lib/asunit4/"
  t.source_path << "test"
  t.default_size = "900,550"
  t.debug = true
end

desc "Compile and run the test swf"
flashplayer :test => "<%= bin %>/<%= test_swf_name %>"

task :default => :debug
