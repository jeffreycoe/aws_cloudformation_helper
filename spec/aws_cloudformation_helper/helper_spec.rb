# frozen_string_literal: true

require 'aws_cloudformation_helper/version'

RSpec.describe AWS::CloudFormation::Helper::Version do
  it 'has a version number' do
    expect(AWS::CloudFormation::Helper::Version::GEM_VERSION).not_to be nil
  end
end
