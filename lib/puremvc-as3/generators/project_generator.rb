module PureMVC_AS3
  class AS3ProjectGenerator < FlashSDK::ProjectGenerator
    
    ## These params below are inherited from the AS3 ProjectGenerator and are available
    # add_param :src, String, { :default => "src"}
    # add_param :lib, String, { :default => "lib"}
    # add_param :bin, String, { :default => "bin"}
    # add_param :skins, String, { :default => "skins"}
    # add_param :test, String, { :default => "test"}    
    
    ##
    # Send flag shallow to prevent subdirectories vo, dto from being created
    add_param :shallow, Boolean,    {                           :description => "If true, only main level directories will be created." }
    add_param :proxy, String,       { :default => "proxy",      :description => "The name of the src directory containing the proxies." }
    add_param :vo, String,          { :default => "vo",         :description => "The name of the src directory containing the vos." }
    add_param :view, String,        { :default => "view",       :description => "The name of the src directory containing the views." }
    add_param :mediators, String,   { :default => "mediators",  :description => "The name of the src directory containing the mediators." }
    # add_param :components, String,  { :default => "components", :description => "The name of the src directory containing the components."  }
    add_param :model, String,       { :default => "model",      :description => "The name of the src directory containing the models." }
    add_param :controller, String,  { :default => "controller", :description => "The name of the src directory containing the controllers." }
    add_param :commands, String,    { :default => "commands",   :description => "The name of the src directory containing the commands." }
    # add_param :dto, String,         { :default => "dto",        :description => "The name of the src directory containing the dtos." }
    add_param :package, String,     { :default => "project",    :description => "The root package for the code to live in, using sytax like 'com/example'" }  

    set :name, :puremvc

    def manifest
      directory project_name do

        say 'Creating root level files and directories.'
        
        template "Rakefile", "PureMVCRakefile.rb"
        template "Gemfile",  "PureMVCGemfile.rb"
        
        directory lib
        directory bin

        say 'Creating src directories and classes.'
        directory src do
          template "#{project_name}.#{main_class_ext}", "PureMVCMain.as"
        
          directory package_directory do
            
            template "ApplicationFacade.as"
            
            directory model do
              directory proxy
              directory vo unless shallow
            end
        
            directory view do
              directory mediators
            end
        
            directory controller do
              directory commands do
                template "StartupCommand.as"
              end
            end
        
            directory 'utils' do
              template "Notifications.as"
            end
            
          end
        end
        
        say 'Creating test level files and directories.'
        directory test do
          template "#{test_runner_name}.#{main_class_ext}", "AS3TestRunner.as"
          template "AllTests.as"
          
          directory package_directory do
            directory model do
              directory proxy
              directory vo unless shallow
            end
        
            directory view do
              directory mediators
            end
        
            directory controller do
              directory commands
            end
        
          end
        
        end unless !:test
        
      end

    end

    protected

      def project_name
        return input.camel_case
      end

      def package_directory
        split_parts package
      end

      def class_directory
        parts = input_in_parts
        if parts.size > 1
          parts.pop
          return File.join src, *parts
        end
        return src
      end

      def package_name
        parts = split_parts package
        return "#{parts.join('.')}"
      end

      def class_name
        parts = input_in_parts
        parts.pop.camel_case
      end

      # The file extension of the main class and main test runner class.
      # Easily overridable by any subclass. This will only ever be "as" or "mxml"
      def main_class_ext
        return "as"
      end
      
      def context_package
        if package_name != ""
          return package_name + ".*"
        end
        "*"
      end

      def input_in_parts
        split_parts input
      end

      def split_parts(value)
        provided_input = value
        if provided_input.include?('/')
          provided_input.gsub! /^#{src}\//, ''
          provided_input = provided_input.split('/').join('.')
        end

        provided_input.gsub!(/\.as$/, '')
        provided_input.gsub!(/\.mxml$/, '')
        provided_input.gsub!(/\.xml$/, '')

        provided_input.split('.')
      end

      # override
      # def test_swf_name
      #   "#{class_name}-test.swf"
      # end

  end
end
