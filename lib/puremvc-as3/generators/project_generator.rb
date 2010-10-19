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
    add_param :shallow, Boolean
    add_param :proxy, String, { :default => "proxy" }
    add_param :vo, String, { :default => "vo" }
    add_param :view, String, { :default => "view" }
    add_param :mediators, String, { :default => "mediators" }
    add_param :components, String, { :default => "components" }
    add_param :model, String, { :default => "model" }
    add_param :controller, String, { :default => "controller" }
    add_param :commands, String, { :default => "commands" }
    add_param :dto, String, { :default => "dto" }
    add_param :package, String, { :default => "project" }  

    def manifest
      directory project_name do

        template "Rakefile", "PureMVCRakefile.rb"
        template "Gemfile",  "PureMVCGemfile.rb"
        
        directory lib
        directory bin

        directory src do
          template "#{project_name}.#{main_class_ext}", "PureMVCMain.as"
        
          directory package_directory do
            
            template "ApplicationFacade.as", "ApplicationFacade.as"
            
            directory model do
              directory proxy
              directory vo unless shallow
            end
        
            directory view do
              directory mediators
            end
        
            directory controller do
              directory commands do
                template "StartupCommand.as", "StartupCommand.as"
              end
            end
        
            directory 'utils' do
              template "Notifications.as", "Notifications.as"
            end
            
          end
        end
        
        # directory test do
        #   template "#{test_runner_name}.#{main_class_ext}", "AS3TestRunner.as"
        # 
        #   directory package_directory do
        #     directory model do
        #       directory proxy
        #       directory vo unless shallow
        #     end
        # 
        #     directory view do
        #       directory mediators
        #       directory components
        #       directory skins
        #     end
        # 
        #     directory controller do
        #       directory commands
        #     end
        # 
        #     directory service do
        #       directory dto unless shallow
        #     end
        # 
        #   end
        # 
        # end
        
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
