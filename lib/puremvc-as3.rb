require 'sprout'
# require 'papervision3d/version'

module PureMVC_AS3
  # Your code goes here...
  
  NAME = "puremvc-as3"
  VERSION = "2.0.4"
  
  SVN_URL = "http://svn.puremvc.org/PureMVC_AS3/tags/#{VERSION}/"
  SVN_DIR = "./#{VERSION}/"
  
  # WARNING, PureMVC's download zip is version agnostic. This may result in incremented PureMVC version
  # beyond the accurate version number of this sprout/gem.
  
  # Perhaps in order to correct this, the svn source should be retrieved instead. (TODO)
  
end

Sprout::Specification.new do |s|
   s.name    = PureMVC_AS3::NAME
   s.version = PureMVC_AS3::VERSION
   
   s.add_file_target do |t|
     t.platform = :universal
     t.add_library :swc, "../#{PureMVC_AS3::SVN_DIR}bin"
   end
   
end
