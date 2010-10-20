require 'bundler'
Bundler.require

require 'rake/clean'
require 'lib/rake/rename'
require 'rake/testtask'

CLOBBER.add PureMVC_AS3::SVN_DIR
CLEAN.add 'pkg'
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



namespace :test do

  Rake::TestTask.new(:units) do |t|
    t.libs << "test/unit"
    t.test_files = FileList["test/unit/*_test.rb"]
    t.verbose = true
  end

  namespace :gens do
    
    CLEAN.add 'TestProject'
    
    desc 'Create a test project using the generator named puremvc-as3'
    task :as3 => [:clean, :install] do
      puts `puremvc-as3 TestProject`
      # puts `cd TestProject`
      # puts `bundle install vendor`
    end
    
  end

end

desc "Run tests"
task :test => 'test:units'

# task :default => :test:gens:as3