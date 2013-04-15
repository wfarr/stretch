# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stretch/version'

Gem::Specification.new do |spec|
  spec.name          = "stretch"
  spec.version       = Stretch::VERSION
  spec.authors       = ["Will Farrington"]
  spec.email         = ["wfarr@github.com"]
  spec.description   = %q{An Elasticsearch client library}
  spec.summary       = %q{It's not anywhere near complete at this time, but
    the code is pretty all right allegedly.
  }
  spec.homepage      = "https://github.com/wfarr/stretch"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday",    "~> 0.8.0"
  spec.add_dependency "multi_json", "~> 1.7.2"

  spec.add_development_dependency "bundler",  "~> 1.2"
  spec.add_development_dependency "minitest", "~> 4.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
end
