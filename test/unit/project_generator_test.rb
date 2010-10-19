require File.join(File.dirname(__FILE__), "test_helper")

class ProjectGeneratorTest < Test::Unit::TestCase
  include SproutTestCase

  context "A new Project generator" do

    setup do
      @temp             = File.join(fixtures, 'generators', 'tmp')
      FileUtils.mkdir_p @temp
      @generator        = PureMVC_AS3::AS3ProjectGenerator.new
      @generator.path   = @temp
      @generator.logger = StringIO.new
    end

    teardown do
      remove_file @temp
    end

    should "generate a new Project" do
      @generator.input = "Fwee"
      @generator.execute

      input_dir = File.join(@temp, "Fwee")
            
      assert_directory input_dir
      puts 'testing rakefile' 
      rakefile = File.join(input_dir, "Rakefile")
      assert_file rakefile
      assert_file rakefile do |content|
        assert_match /src\/Fwee.as/, content
      end
      
      gemfile = File.join(input_dir, "Gemfile")
      assert_file gemfile

      src_dir = File.join(input_dir, "src")
      assert_directory src_dir

      main_file = File.join(src_dir, "Fwee.as")
      assert_file main_file
            
      lib_dir = File.join(input_dir, "lib")
      assert_directory lib_dir

      puts 'testing bin dir'
      bin_dir = File.join(input_dir, "bin")
      assert_directory bin_dir
      
    end

    should "respect shallow" do
      @generator.input = "Fwi"
      @generator.shallow = true
      @generator.execute
    
      input_dir = File.join(@temp, "Fwi")
      assert_directory input_dir
    
      vo_dir = File.join(input_dir, "src", "model", "vo")
      assert !File.exists?(vo_dir)
    
      dto_dir = File.join(input_dir, "src", "service", "dto")
      assert !File.exists?(dto_dir)
    
    end
    
    should "add package directories" do
      @generator.input = "Fwo"
      @generator.package = "com/developsigner"
      @generator.execute
    
      input_dir = File.join(@temp, "Fwo")
      assert_directory input_dir
    
      src_dir = File.join(input_dir, "src")
      assert_directory src_dir
    
      package_dir = File.join(src_dir, "com", "developsigner")
      assert_directory package_dir

      puts 'testing model dir'
      model_dir = File.join(package_dir, "model")
      assert_directory model_dir

      puts 'testing view dir'
      view_dir = File.join(package_dir, "view")
      assert_directory view_dir

      puts 'testing controller dir'
      controller_dir = File.join(package_dir, "controller")
      assert_directory controller_dir

      #Second level directories

      puts 'testing proxy dir'
      proxy_dir = File.join(model_dir, "proxy")
      assert_directory proxy_dir

      puts 'testing vo dir'
      vo_dir = File.join(model_dir, "vo")
      assert_directory vo_dir

      puts 'testing mediators_dir'
      mediators_dir = File.join(view_dir, "mediators")
      assert_directory mediators_dir

      puts 'testing commands_dir'
      commands_dir = File.join(controller_dir, "commands")
      assert_directory commands_dir

      
      main_file = File.join(src_dir, "Fwo.as")
      assert_file main_file do |content|
        # assert_match /FwoCompleteHandler/, content
        # assert_match /com.developsigner.*/, content
      end
    end
    
  end
end
