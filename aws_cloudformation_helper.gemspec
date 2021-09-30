# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aws_cloudformation_helper/version'

Gem::Specification.new do |spec|
  spec.name          = 'aws_cloudformation_helper'
  spec.version       = AWS::CloudFormation::Helper::Version::GEM_VERSION
  spec.authors       = ['Jeffrey Coe']

  spec.summary       = 'Assists with the development of custom resources for AWS CloudFormation using the Ruby runtime'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/jeffreycoe/aws_cloudformation_helper'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the allowed_push_host
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  if spec.respond_to?(:metadata)
    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/jeffreycoe/aws_cloudformation_helper'
    spec.metadata['changelog_uri'] = 'https://github.com/jeffreycoe/aws_cloudformation_helper/blob/master/CHANGELOG.md'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '~> 2.4', '~> 2.5', '~>2.7'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake', '~> 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'rubocop', '~> 0.79'
end
