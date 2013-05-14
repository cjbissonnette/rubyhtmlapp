#bundler
require 'bundler/setup'

#ruby internals
require 'find'

#external gems
require 'sprockets'
require 'tilt'
require 'thor'
require 'templater'

#gem files
require 'rubyhtmlapp/version'
require 'rubyhtmlapp/helpers'
require 'rubyhtmlapp/cli'

module RubyHtmlApp
  class HtmlApp
    include Helpers
    
    def initialize(application_name, args={})
      @app_name = application_name
      @app_path = args.fetch(:app_path, File.join('lib', application_name))
      @partial_path = File.join(@app_path, args.fetch(:partial_path, "html"))
      @layout_path = File.join(@app_path, args.fetch(:layout_path, "html"))
      @html_path = File.join(@app_path, args.fetch(:html_path, "html"))
      @html_path = File.join(@app_path, args.fetch(:html_path, "html"))
      @js_path = File.join(@app_path, args.fetch(:js_path, "javascripts"))
      @css_path = File.join(@app_path, args.fetch(:css_path, "stylesheets"))
      @image_path = File.join(@app_path, args.fetch(:image_path, "images"))
      @js_compressor = args.fetch(:js_compressor, nil) #Uglifier.new
      @css_compressor = args.fetch(:css_compressor, nil) #YUI::CssCompressor.new
      @build_path = args.fetch(:build_path, 'dist')
      @build_name = args.fetch(:build_name, @app_name)
      @build_name.concat('.html') if File.extname(@build_name) == ''
      @main_js = args.fetch(:app_js, "application.js")
      @main_css = args.fetch(:app_css, "application.css")
      @main_layout = args.fetch(:app_layout, "layout.html*")
      @main_html = args.fetch(:app_html, "application.html*")
      @sprocket_env = Sprockets::Environment.new
    end
  
    def compile_resources()
      @sprocket_env.append_path @js_path
      @sprocket_env.append_path @css_path
      @sprocket_env.append_path @image_path
      @sprocket_env.js_compressor  = @js_compressor
      @sprocket_env.css_compressor = @css_compressor
      
      css_source = @sprocket_env[@main_css].source
      js_source = @sprocket_env[@main_js].source
      js_source.gsub!('</script>', '<\/script>')
      
      FileUtils.mkpath(@build_path) if !File.exists?(@build_path)
      File.open(File.join(@build_path, @build_name), "w") do |f|
        layout = find_f(@layout_path, @main_layout)
        output = Tilt.new(find_f(@html_path, @main_html)).render(self,
                                                                inline_js: js_source,
                                                                inline_css: css_source)
        if layout
          output = Tilt.new(layout).render(self,
                                           inline_js: js_source,
                                           inline_css: css_source) { output }
        end
        f.write(output)
      end
    end
  end
end
