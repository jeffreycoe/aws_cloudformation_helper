# frozen_string_literal: true

require 'spec_helper'

require_relative '../mock_lambda_handler.rb'

RSpec.describe AWS::CloudFormation::Helper::Response do
  let(:mock_handler) { MockLambdaHandler.new }
  let(:mock_helper) { AWS::CloudFormation::Helper.new(mock_handler, mock_handler.event, mock_handler.context) }
  let(:mock_response) { AWS::CloudFormation::Helper::Response.new }

  it 'responds to failure method' do
    expect(mock_response).to respond_to(:failure).with(1).argument
  end

  it 'responds to send_response method' do
    expect(mock_response).to respond_to(:send_response).with(3).argument
  end

  it 'responds to success method' do
    expect(mock_response).to respond_to(:success).with(1).argument
  end

  it 'does not respond to http_request method' do
    expect(mock_response).not_to respond_to(:http_request)
  end

  it 'does not respond to physical_resource_id method' do
    expect(mock_response).not_to respond_to(:physical_resource_id)
  end

  it 'does not respond to generate_physical_id method' do
    expect(mock_response).not_to respond_to(:generate_physical_id)
  end

  it 'does not respond to provider_response method' do
    expect(mock_response).not_to respond_to(:provider_response)
  end
end
