# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "authentic_jwt/version"

Gem::Specification.new do |spec|
  spec.name          = "authentic-jwt"
  spec.version       = AuthenticJwt::VERSION
  spec.authors       = ["Authentic Limited"]
  spec.email         = ["rubygems@kotiri.com"]

  spec.summary       = "Client authentication for Authentic Apps"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/mytours/authentic-jwt"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_dependency "jwt"
  spec.add_dependency "multi_json"

  spec.required_ruby_version = ">= 3.1.4"

  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
end
