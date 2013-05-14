# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require '<%=@params[:name]%>/version'

Gem::Specification.new do |spec|
  spec.name          = <%=@params[:name].inspect%>
  spec.version       = <%=@params[:constant_name]%>::VERSION
  spec.authors       = [<%=@params[:author].inspect%>]
  spec.email         = [<%=@params[:email].inspect%>]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
<% if @params[:test] -%>
  spec.add_development_dependency "<%=@params[:test]%>"
<% end -%>
  spec.add_dependency "rubyhtmlapp", "~> 0.0.1"
  spec.add_dependency "thor", "~> 0.18.1"
  spec.add_dependency "sass", "~> 3.2.8"
  spec.add_dependency "haml", "~> 4.0.2"
end
