# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "minitest-fail"
  spec.version       = "0.0.3"
  spec.authors       = ["Teo Ljungberg"]
  spec.email         = ["teo.ljungberg@gmail.com"]
  spec.summary       = %q{Make an empty test fail}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/teoljungberg/minitest-fail"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.require_paths = ["lib"]

  spec.add_dependency "minitest", "~> 5.2"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
