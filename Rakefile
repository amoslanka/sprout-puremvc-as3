require 'bundler'
require 'lib/puremvc-as3'
require 'lib/rake/rename'
require 'rake/clean'

CLOBBER.add PureMVC_AS3::SVN_DIR

Bundler::GemHelper.install_tasks

# rename 'package' task to 'package-local' task
Rake::Task[:build].rename(:"build_gem")

desc 'Build the gem after svn exporting the proper version of the PureMVC svn repo'
task :build => [ :svn_export, :build_gem ]

desc 'Run svn export on the remote svn repository of PureMVC'
task :svn_export do
  if !File.directory? PureMVC_AS3::SVN_DIR
    `svn export #{PureMVC_AS3::SVN_URL} #{PureMVC_AS3::SVN_DIR}`
  else
    puts "** The remote repository has already been exported into the local directory (#{PureMVC_AS3::SVN_DIR}). To re-export it, run rake task 'clobber'"
  end  
end

