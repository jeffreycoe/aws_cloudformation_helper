# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aws_cloudformation_helper/version'

Gem::Specification.new do |spec|
  spec.name          = 'aws_cloudformation_helper'
  spec.version       = AWS::CloudFormation::Helper::Version::GEM_VERSION
  spec.authors       = ['Jeffrey Coe']
  spec.email         = ['jeffrey.coe@cerner.com']

  spec.summary       = 'Provides helper methods for AWS CloudFormation'
  spec.description   = 'Provides helper methods for AWS CloudFormation'
  spec.homepage      = 'https://github.com/jeffreycoe/aws_cloudformation_helper'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the allowed_push_host
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/jeffreycoe/aws_cloudformation_helper'
    spec.metadata['changelog_uri'] = 'https://github.com/jeffreycoe/aws_cloudformation_helper/CHANGELOG.md'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop', '~> 0.79'
  spec.add_development_dependency 'rspec', '~> 3.2'
end
