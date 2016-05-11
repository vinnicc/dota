# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dota/version'

Gem::Specification.new do |spec|
  spec.name          = "dota"
  spec.version       = Dota::VERSION
  spec.authors       = ["Vinni Carlo Caños"]
  spec.email         = ["vinnicc@gmail.com"]
  spec.summary       = %q{Ruby client for the Dota 2 WebAPI}
  spec.description   = %q{Ruby client for the Dota 2 WebAPI}
  spec.homepage      = "http://github.com/vinnicc/dota"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "facets", "~> 3.0"
  spec.add_dependency "faraday", "~> 0.9.1"
  spec.add_dependency "faraday_middleware", "~> 0.9.1"

  spec.add_development_dependency "codeclimate-test-reporter",  "~> 0.5.0"
  spec.add_development_dependency "dotenv",  "~> 2.1"
  spec.add_development_dependency "guard-rspec",  "~> 4.6"
  spec.add_development_dependency "listen", "~> 2.10"
  spec.add_development_dependency "pry",  "~> 0.10"
  spec.add_development_dependency "rake",  "~> 11.1"
  spec.add_development_dependency "rspec",  "~> 3.4"
  spec.add_development_dependency "vcr",  "~> 3.0"
end
