# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'moiper/version'

Gem::Specification.new do |gem|
  gem.name          = "moiper"
  gem.version       = Moiper::VERSION
  gem.authors       = ["Rodrigo Navarro"]
  gem.email         = ["rnavarro1@gmail.com"]
  gem.description   = %q{Moip payment service integration library.}
  gem.summary       = gem.description
  gem.homepage      = "http://rubygems.org/gems/moiper"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "nokogiri"
  gem.add_development_dependency "rspec"
end
