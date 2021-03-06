lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ruboty/kokodeikku/version"

Gem::Specification.new do |spec|
  spec.name          = "ruboty-kokodeikku"
  spec.version       = Ruboty::Kokodeikku::VERSION
  spec.authors       = ["Ryo Nakamura"]
  spec.email         = ["r7kamura@gmail.com"]
  spec.summary       = "Ruboty plug-in to find haiku from our daily conversations."
  spec.homepage      = "https://github.com/r7kamura/ruboty-kokodeikku"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "ikku", ">= 0.1.1"
  spec.add_runtime_dependency "ruboty"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
