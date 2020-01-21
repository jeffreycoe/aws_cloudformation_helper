# frozen_string_literal: true

require 'aws_cloudformation_helper/event'
require 'aws_cloudformation_helper/logger'
require 'aws_cloudformation_helper/response'
require 'aws_cloudformation_helper/version'

module AWS
  module CloudFormation
    # Main module
    class Helper
      class << self
        attr_accessor :logger
        attr_accessor :log_level
        attr_accessor :data

        attr_reader :context
        attr_reader :event

        def default_logger
          @log_level = DEFAULT_LOG_LEVEL if @log_level.nil?
          Logger.new
        end

        def initialize(main_class, event, context)
          # Ruby context object: https://docs.aws.amazon.com/lambda/latest/dg/ruby-context.html
          @context = context

          # Initialize the event object
          @event = AWS::CloudFormation::Helper::Event.new(event)
          logger.debug("Event: #{event.inspect}")
          @event.execute(main_class.method(:create), main_class.method(:delete), main_class.method(:update))
        end

        DEFAULT_LOG_LEVEL = :info
      end
    end
  end
end

AWS::CloudFormation::Helper.logger = AWS::CloudFormation::Helper.default_logger
