# frozen_string_literal: true

module AWS
  module CloudFormation
    class Helper
      # Creates an Event object based on the event data from CloudFormation
      class Event
        class << self
          attr_accessor :instance
        end

        attr_reader :logical_resource_id
        attr_reader :physical_resource_id
        attr_reader :resource_properties
        attr_reader :resource_type
        attr_reader :response_url
        attr_reader :request_id
        attr_reader :request_type
        attr_reader :stack_id

        def initialize(event, create_method, delete_method, update_method)
          parse_event_data(event)

          @cfn_response = AWS::CloudFormation::Helper::Response.new
          @create_method = create_method
          @delete_method = delete_method
          @update_method = update_method
        end

        def execute
          Helper.logger.debug("Request Type: #{@request_type}")

          case @request_type.downcase
          when 'create'
            execute_create
          when 'delete'
            execute_delete
          when 'update'
            execute_update
          else
            err_msg = "Invalid request type specified. Request Type: #{@request_type}"
            Helper.logger.error(err_msg)
            @cfn_response.failure(err_msg)
            raise err_msg
          end
        end

        def execute_create
          Helper.logger.debug('Executing method for create event')

          @create_method.call
          @cfn_response.success
        rescue StandardError => e
          @cfn_response.failure(e)
          raise e
        end

        def execute_delete
          Helper.logger.debug('Executing method for delete event')

          @delete_method.call
          @cfn_response.success
        rescue StandardError => e
          @cfn_response.failure(e)
          raise e
        end

        def execute_update
          Helper.logger.debug('Executing method for update event')

          @update_method.call
          @cfn_response.success
        rescue StandardError => e
          @cfn_response.failure(e)
          raise e
        end

        private

        def parse_event_data(event)
          raise 'The event object from Lambda is nil.' if event.nil?

          @logical_resource_id = event['LogicalResourceId'].to_s
          @physical_resource_id = event['PhysicalResourceId'] if event.keys.include?('PhysicalResourceId')
          @resource_properties = event['ResourceProperties']
          @resource_type = event['ResourceType'].to_s
          @response_url = event['ResponseURL'].to_s
          @request_id = event['RequestId'].to_s
          @request_type = event['RequestType'].to_s
          @stack_id = event['StackId'].to_s
        end

        def valid_json?(json)
          ::JSON.parse(json)
          true
        rescue ::JSON::ParserError
          false
        end
      end
    end
  end
end
