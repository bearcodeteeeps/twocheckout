# -*- encoding: utf-8 -*-
require File.expand_path('../lib/twocheckout/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Craig Christenson", "Ernesto Garcia"]
  gem.email         = ["christensoncraig@gmail.com", "ernesto+git@gnapse.com"]
  gem.description   = %q{twocheckout provides a nice ruby interface to access the 2Checkout API}
  gem.summary       = %q{Ruby wrapper for 2Checkout API}
  gem.homepage      = "http://github.com/craigchristenson/twocheckout"

  gem.add_dependency("rest-client", "~> 1.6.7")

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "twocheckout"
  gem.require_paths = ["lib"]
  gem.version       = Twocheckout::VERSION
end
