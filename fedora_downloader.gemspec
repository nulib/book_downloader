# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fedora_downloader/version'

Gem::Specification.new do |spec|
  spec.name          = 'fedora_downloader'
  spec.version       = FedoraDownloader::VERSION
  spec.authors       = ['Brendan Quinn']
  spec.email         = ['brendan-quinn@northwestern.edu']

  spec.summary       = 'Download page images from books in Fedora 3'
  spec.homepage      = 'https://github.com/nulib/fedora_downloader'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rubydora', '~> 2.0'
  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'dotenv', '~> 2.2'
end
