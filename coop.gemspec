lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'coop_al/version'

Gem::Specification.new do |spec|
  spec.name = 'coop_al'
  spec.version = CoopAl::VERSION
  spec.authors = ['Jamie Hale']
  spec.email = ['jamie@smallarmyofnerds.com']
  spec.summary = 'Adventurers League Character Log Generator'
  spec.description = 'Tool for automated character growth through predefined adventures'
  spec.homepage = 'https://github.com/jamiehale/coop'
  spec.license = 'GPL-3.0'

  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_dependency 'tablescript', '~> 1.0'
  spec.add_dependency 'rpg_lib', '~> 1.0'
  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'cucumber', '~> 2.4'
  spec.add_development_dependency 'simplecov', '~> 0.13'
  spec.add_development_dependency 'rubocop', '~> 0.47'
end
