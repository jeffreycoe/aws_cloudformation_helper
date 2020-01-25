# frozen_string_literal: true

require 'securerandom'

class MockLambdaHandler
  class LambdaContext
    def initialize
      @clock_diff = 1579980692980
      @deadline_ms = 1579981801350
      @aws_request_id = ::SecureRandom.uuid
      @invoked_function_arn = 'arn:aws:lambda:us-east-1:012345678912:function:mock_function'
      @log_group_name = '/aws/lambda/mock_function'
      @log_stream_name = '2020/01/25/[$LATEST]c732894873ba3828d8a8d7da987'
      @function_name = 'mock_function'
      @memory_limit_in_mb = '128'
      @function_version = '$LATEST'
    end
  end

  attr_accessor :context
  attr_accessor :event

  def create; end
  def delete; end
  def update; end

  def initialize
    @event = {
      'RequestType' => 'Create',
      'ResponseURL' => 'https://test.endpoint.mock',
      'StackId' => 'arn:aws:cloudformation:us-east-2:123456789012:stack/MyStack/guid',
      'RequestId' => 'unique id for this create request',
      'ResourceType' => 'Custom::TestResource',
      'LogicalResourceId' => 'MyTestResource',
      'ResourceProperties' => {
        'ClusterName' => 'test-cluster',
        'ConfigMap' => 'some_data'
      }
    }

    @context = MockLambdaHandler::LambdaContext.new
  end
end
