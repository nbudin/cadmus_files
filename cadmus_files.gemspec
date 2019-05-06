# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cadmus_files/version'

Gem::Specification.new do |spec|
  spec.name          = "cadmus_files"
  spec.version       = CadmusFiles::VERSION
  spec.authors       = ["Nat Budin"]
  spec.email         = ["natbudin@gmail.com"]

  spec.summary       = %q{File uploads for Cadmus sites}
  spec.description   = %q{Adds file uploading and linking to the Cadmus micro-CMS using Carrierwave}
  spec.homepage      = "https://github.com/nbudin/cadmus_files"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.0"

  spec.add_dependency "rails", ">= 5.2.0"
  spec.add_dependency "cadmus"
  spec.add_dependency "liquid"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
