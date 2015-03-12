# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'celluloid/marathon/version'

Gem::Specification.new do |spec|
  spec.name = 'celluloid-marathon'
  spec.version = Celluloid::Marathon::VERSION
  spec.authors = ['Michal Kočárek']
  spec.email = ['michal.kocarek@brainbox.cz']

  spec.summary = %q{Celluloid actors designed for long-time running}
  spec.description = %q{Package extends Celluloid with actors suitable for running neverending tasks and enables their graceful termination.}
  spec.homepage = 'https://github.com/michal-kocarek/celluloid-marathon'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.2'

  if spec.respond_to?(:metadata)
    #spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.add_dependency 'celluloid'

  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5'
  spec.add_development_dependency 'minitest-reporters'
  spec.add_development_dependency 'shoulda-context'
  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'simplecov'
end
