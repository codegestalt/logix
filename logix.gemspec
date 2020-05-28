# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'logix/version'

Gem::Specification.new do |spec|
  spec.name          = "logix"
  spec.version       = Logix::VERSION
  spec.authors       = ["Rodrigo Haenggi"]
  spec.email         = ["rodrigo@codegestalt.com"]

  spec.summary       = %q{Gem to connect to Crealogix API.}
  spec.description   = %q{Something something dark side}
  spec.homepage      = "https://github.com/codegestalt/logix"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://gems.codegestalt.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "cmxl", "~> 1.0"
  spec.add_dependency "faraday", "~> 0.9.2"
  spec.add_dependency "faraday-cookie_jar", "~> 0.0.6"
  spec.add_dependency "crack", "~> 0.4.2"

  spec.add_development_dependency "bundler", ">= 1.16"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-vcr"
  spec.add_development_dependency "pry"
end
