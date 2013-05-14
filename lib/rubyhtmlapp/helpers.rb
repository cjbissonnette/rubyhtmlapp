require 'tilt'
require 'sprockets'
require 'find'

module RubyHtmlApp
  module Helpers
    def render(partial, locals={}, &block)
      Tilt.new(find_f(@partial_path, "_#{partial}.html*")).render(self, locals, &block)
    end
    
    def include_dir(dir, locals={}, &block)
      html = ""
      find_f_each(File.join(@partial_path, dir), "*.html*") do |f|
        html.concat(Tilt.new(f).render(self, locals, &block))
      end
      return html
    end  
      
    def asset_data_uri(path)
      asset = @sprocket_env[path]
      Sprockets::Context.new(@sprocket_env, asset.logical_path, asset.pathname).asset_data_uri(path)
    end

    def find_f(path, pattern)
      Find.find(path) do |f|
        return f if File.fnmatch?(pattern, File.basename(f))
      end
      nil
    end
    
    def find_f_each(path, pattern)
      Find.find(path) do |f|
        yield(f) if File.fnmatch?(pattern, File.basename(f))
      end
    end
  end
end