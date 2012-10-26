# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'github-key-upload/version'

Gem::Specification.new do |gem|
  gem.name          = "github-key-upload"
  gem.version       = Github::Key::Upload::VERSION
  gem.authors       = ["Giovanni Intini"]
  gem.email         = ["giovanni@mikamai.com"]
  gem.description   = %q{Litte command utility that uses the github api to create a public key}
  gem.summary       = %q{Creates GitHub user keys via api}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "github_api"
  gem.add_dependency "slop"
end
