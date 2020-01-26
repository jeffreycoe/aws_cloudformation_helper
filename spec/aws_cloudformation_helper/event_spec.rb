# frozen_string_literal: true

require 'spec_helper'

require_relative '../mock_lambda_handler.rb'

RSpec.describe 'helper event class' do
  let(:mock_handler) { MockLambdaHandler.new }
  let(:mock_helper) { AWS::CloudFormation::Helper.new(mock_handler, mock_handler.event, mock_handler.context) }
  let(:mock_event) { mock_helper.event }

  it 'has logical_resource_id' do
    expect(mock_event.logical_resource_id).to be 'MyTestResource'
  end

  it 'has physical_resource_id' do
    expect(mock_event.physical_resource_id).to be nil
  end

  it 'has resource_properties' do
    expect(mock_event.resource_properties).to include(
      'ClusterName' => 'test-cluster',
      'ConfigMap' => 'some_data'
    )
  end

  it 'has resource_type' do
    expect(mock_event.resource_type).to be 'Custom::TestResource'
  end

  it 'has response_url' do
    expect(mock_event.response_url).to be 'https://test.endpoint.mock'
  end

  it 'has request_id' do
    expect(mock_event.request_id).to be 'unique id for this create request'
  end

  it 'has request_type' do
    expect(mock_event.request_type).to be 'Create'
  end

  it 'has stack_id' do
    expect(mock_event.stack_id).to be 'arn:aws:cloudformation:us-east-2:123456789012:stack/MyStack/guid'
  end

  it 'responds to execute method' do
    expect(mock_helper.event).to respond_to(:execute).with(0).argument
  end

  it 'responds to execute_create method' do
    expect(mock_helper.event).to respond_to(:execute_create).with(0).argument
  end

  it 'responds to execute_delete method' do
    expect(mock_helper.event).to respond_to(:execute_delete).with(0).argument
  end

  it 'responds to execute_update method' do
    expect(mock_helper.event).to respond_to(:execute_update).with(0).argument
  end

  it 'is event object' do
    expect(mock_event).not_to be nil
    expect(mock_event).to be_an_instance_of(AWS::CloudFormation::Helper::Event)
  end

  it 'raises exception if event data is nil' do
    expect { AWS::CloudFormation::Helper::Event.new(nil, def create; end, def delete; end, def update; end) }
      .to raise_error('The event object from Lambda is nil.')
  end
end
