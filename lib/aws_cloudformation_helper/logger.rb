# frozen_string_literal: true

module AWS
  module CloudFormation
    class Helper
      # Main class to handle logging
      class Logger
        # https://docs.aws.amazon.com/lambda/latest/dg/ruby-logging.html
        DEFAULT_LOG_LEVEL = :info

        attr_accessor :log_level

        def initialize
          @log_level ||= DEFAULT_LOG_LEVEL if @log_level.nil?
        end

        def error(msg)
          msg = format_log_entry('ERROR', msg)
          warn msg
        end

        def info(msg)
          msg = format_log_entry('INFO', msg)
          puts msg
        end

        def warn(msg)
          return if @log_level == :info

          msg = format_log_entry('WARN', msg)
          puts msg
        end

        def debug(msg)
          return if @log_level != :debug

          msg = format_log_entry('DEBUG', msg)
          puts msg
        end

        private

        def format_log_entry(severity, msg)
          msg = "[#{::Time.now}] #{severity}: #{msg}"
          msg
        end
      end
    end
  end
end
