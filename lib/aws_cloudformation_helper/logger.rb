# frozen_string_literal: true

require 'logger'

module AWS
  module CloudFormation
    class Helper
      # Main class to handle logging
      class Logger
        # https://docs.aws.amazon.com/lambda/latest/dg/ruby-logging.html
        DEFAULT_LOG_LEVEL = :info

        attr_accessor :log_level
        attr_accessor :stdout
        attr_accessor :stderr

        def initialize(log_level = nil, stdout = STDOUT, stderr = STDERR)
          @log_level = DEFAULT_LOG_LEVEL
          @log_level = log_level unless log_level.nil?
          @stdout = stdout
          @stderr = stderr
        end

        def error(msg)
          error_logger.error(msg)
        end

        def info(msg)
          logger.info(msg)
        end

        def warn(msg)
          logger.warn(msg)
        end

        def debug(msg)
          logger.debug(msg)
        end

        private

        def logger
          @logger ||= ::Logger.new(@stdout)
          @logger.level = @log_level
          @logger
        end

        def error_logger
          @logger ||= ::Logger.new(@stderr)
          @logger.level = @log_level
          @logger
        end
      end
    end
  end
end
