require 'puremvc-as3/version'
require 'flashsdk'
require 'puremvc-as3/generators/project_generator'

module PureMVC_AS3
  SVN_URL = "http://svn.puremvc.org/PureMVC_AS3/tags/#{VERSION}/"
  SVN_DIR = "./#{VERSION}/"
end

Sprout::Specification.new do |s|
   s.name    = PureMVC_AS3::NAME
   s.version = PureMVC_AS3::VERSION
   
   s.add_file_target do |t|
     t.platform = :universal
     t.add_library :swc, "../#{PureMVC_AS3::SVN_DIR}bin"
     t.add_library :src, "../#{PureMVC_AS3::SVN_DIR}src"
     t.add_library :asdocs, "../#{PureMVC_AS3::SVN_DIR}asdoc"
   end
   
end
