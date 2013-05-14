require 'templater'
require 'thor'

module RubyHtmlApp
  class FileGenerator < Templater::Generator
  
    def initialize(target, args)
      @params = args
      super(target)
    end
    
    def self.source_root
      File.join(File.dirname(__FILE__), 'templates')
    end
  end
      
  class CLI < Thor
    desc "create", "create a new ruby html app"
    def create(raw_name)
      name = raw_name.chomp("/")
      namespaced_path = name.tr('-', '/')
      target = File.join(Dir.pwd, name)
      constant_name = name.split('_').map{|p| p[0..0].upcase + p[1..-1] }.join
      constant_name = constant_name.split('-').map{|q| q[0..0].upcase + q[1..-1] }.join('::') if constant_name =~ /-/
      constant_array = constant_name.split('::')
      git_user_name = `git config user.name`.chomp
      git_user_email = `git config user.email`.chomp
      `bundle gem #{raw_name}`
      opts = {
        :name            => name,
        :namespaced_path => namespaced_path,
        :constant_name   => constant_name,
        :constant_array  => constant_array,
        :author          => git_user_name.empty? ? "TODO: Write your name" : git_user_name,
        :email           => git_user_email.empty? ? "TODO: Write your email address" : git_user_email,
        :test            => options[:test]
      }
      gen = FileGenerator.new(name, opts)
      #static files
      FileGenerator.file(:application_html, "html/application.html.haml", "lib/#{name}/html/application.html.haml")
      FileGenerator.file(:layout_html, "html/layout.html.haml", "lib/#{name}/html/layout.html.haml")
      FileGenerator.empty_directory(:images, "lib/#{name}/images/")
      FileGenerator.file(:application_js, "javascripts/application.js", "lib/#{name}/javascripts/application.js")
      FileGenerator.file(:application_css, "stylesheets/application.css", "lib/#{name}/stylesheets/application.css")
      FileGenerator.empty_directory(:dist, "dist/")
      FileGenerator.file(:helpers, "helpers.rb", "lib/#{name}/helpers.rb")
      
      #erb files
      FileGenerator.template(:cli, "cli.rb", "lib/#{name}/cli.rb")
      FileGenerator.template(:run, "run", "bin/#{name}")
      FileGenerator.template(:gemspec, "newgem.gemspec", "#{name}.gemspec")
      FileGenerator.template(:app, "newgem.rb", "lib/#{name}.rb")
      gen.invoke!
      Dir.chdir(name) { `git add .`; `git commit -m "initialize rubyhtmlapp"`;  }
    end
   
  end
end