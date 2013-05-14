# RubyHtmlApp

Creates an inlined html app using sprockets and tilt

## Installation

Add this line to your application's Gemfile:

    gem 'rubyhtmlapp'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rubyhtmlapp

## Usage

To create a blank project run:

    rubyhtmlapp create [project_name]
    
This will intitialize a git repository and setup a simple hello world example.  To 'compile' the project run:

    bundle exec ruby bin/[project_name] compile
    
This will inline all js files located in the lib/[project_name]/javascripts directory, all css files located in lib/[project_name]/stylesheets into the template application.html (using layout.html). The final result will be located in the dist/ directory.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
