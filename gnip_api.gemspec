# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gnip_api/version'

Gem::Specification.new do |spec|
  spec.name          = "gnip_api"
  spec.version       = GnipApi::VERSION
  spec.authors       = ["Amar Daxini"]
  spec.email         = ["amardaxini@gmail.com"]
  spec.description   = %q{Gnip Api libary}
  spec.summary       = %q{Gnip Api libary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "faraday"
  spec.add_dependency "typhoeus"
  spec.add_dependency "multi_json"
  spec.add_dependency "oj"
end
