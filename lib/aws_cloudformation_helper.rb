# frozen_string_literal: true

require 'aws_cloudformation_helper/event'
require 'aws_cloudformation_helper/logger'
require 'aws_cloudformation_helper/response'
require 'aws_cloudformation_helper/version'

module AWS
  module CloudFormation
    # Main module
    class Helper
      attr_reader :event
      attr_reader :context

      def initialize(lambda_class, event, context)
        # Ruby context object: https://docs.aws.amazon.com/lambda/latest/dg/ruby-context.html
        @context = context

        # Initialize event object
        @event = Event.new(event, lambda_class.method(:create),
                           lambda_class.method(:delete), lambda_class.method(:update))
        Event.instance = @event
      end

      def self.logger
        @logger ||= Logger.new
        @logger
      end

      def logger
        self.class.logger
      end
    end
  end
end
