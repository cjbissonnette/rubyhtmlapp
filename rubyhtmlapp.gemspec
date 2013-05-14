# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubyhtmlapp/version'

Gem::Specification.new do |spec|
  spec.name          = "rubyhtmlapp"
  spec.version       = RubyHtmlApp::VERSION
  spec.authors       = ["Curtis Bissonnette"]
  spec.email         = ["cbissonnette@gmail.com"]
  spec.description   = %q{Creates an inlined html app using sprockets and tilt}
  spec.summary       = %q{A simple generator used to setup a project for sprockets and tilt
                          which will compile all source files into a single html file}
  spec.homepage      = "https://github.com/cjbissonnette/rubyhtmlapp"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  
  spec.add_dependency "tilt",      "~> 1.3.6"
  spec.add_dependency "sprockets", "~> 2.9.0"
  spec.add_dependency "templater", "~> 1.0.0"
  spec.add_dependency "thor",      "~> 0.18.1"
  
end
