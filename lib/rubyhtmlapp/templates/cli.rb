require 'thor'

module <%= @params[:constant_name] %>
  class CLI < Thor
    desc "compile", "compile all js, css, and html into a single file"
    def compile()
      app = RubyHtmlApp::HtmlApp.new('<%= @params[:name] %>').compile_resources
    end
  end
end