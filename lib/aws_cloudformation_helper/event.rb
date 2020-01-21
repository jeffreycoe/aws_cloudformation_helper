# frozen_string_literal: true

module AWS
  module CloudFormation
    class Helper
      # Creates an Event object based on the event data from CloudFormation
      class Event
        attr_reader :logical_resource_id
        attr_reader :resource_properties
        attr_reader :resource_type
        attr_reader :response_url
        attr_reader :request_id
        attr_reader :request_type
        attr_reader :stack_id

        def initialize(event)
          parse_event_data(event)
          @cfn_response = AWS::CloudFormation::Helper::Response.new
        end

        def execute(create_method, delete_method, update_method)
          logger.debug("Request Type: #{@request_type}")

          case @request_type.downcase
          when 'create'
            execute_create(create_method)
          when 'delete'
            execute_delete(delete_method)
          when 'update'
            execute_update(update_method)
          else
            err_msg = "Invalid request type specified. Request Type: #{@request_type}"
            logger.error(err_msg)
            @cfn_response.failure(err_msg)
            raise err_msg
          end
        end

        def execute_create(create_method)
          logger.debug('Executing method for create event')

          create_method.call
          @cfn_response.success
        rescue StandardError => e
          @cfn_response.failure(e)
          raise e
        end

        def execute_delete(delete_method)
          logger.debug('Executing method for delete event')

          delete_method.call
          @cfn_response.success
        rescue StandardError => e
          @cfn_response.failure(e)
          raise e
        end

        def execute_update(update_method)
          logger.debug('Executing method for update event')

          update_method.call
          @cfn_response.success
        rescue StandardError => e
          @cfn_response.failure(e)
          raise e
        end

        private

        def parse_event_data(event)
          raise 'ERROR: Event data is not valid JSON.' unless valid_json?(event)

          @logical_resource_id = event['LogicalResourceId']
          @resource_properties = event['ResourceProperties']
          @resource_type = event['ResourceType']
          @response_url = event['ResponseURL']
          @request_id = event['RequestId']
          @request_type = event['RequestType']
          @stack_id = event['StackId']
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
