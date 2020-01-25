# frozen_string_literal: true

require 'spec_helper'

require_relative '../mock_lambda_handler.rb'

RSpec.describe 'main helper class' do
  let(:mock_handler) { MockLambdaHandler.new }
  let(:mock_helper) { AWS::CloudFormation::Helper.new(mock_handler, mock_handler.event, mock_handler.context) }

  it 'responds to logger class method' do
    expect(AWS::CloudFormation::Helper).to respond_to(:logger).with(0).argument
  end

  it 'responds to logger instance method when instantiated' do
    expect(mock_helper).to respond_to(:logger).with(0).argument
  end

  it 'returns event data' do
    expect(mock_helper.event).not_to be nil
  end

  it 'returns context data' do
    expect(mock_helper.context).not_to be nil
  end
end
