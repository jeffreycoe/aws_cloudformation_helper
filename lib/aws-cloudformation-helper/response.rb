require 'net/http'
require 'json'
require 'uri'

module AWS
  module CloudFormation
    class Helper
      class Response
        # https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/crpg-ref-responses.html
        SUCCESS_STATUS = 'SUCCESS'
        FAILURE_STATUS = 'FAILURE'

        def initialize(response_url, stack_id, request_id, logical_resource_id)
          @response_url = response_url
          @stack_id = stack_id
          @request_id = request_id
          @logical_resource_id = logical_resource_id
        end

        def send_response(method, response_url, body = nil)
          uri = ::URI.parse(response_url)
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = (uri.scheme == 'https')

          case method
          when 'PUT'
            request = Net::HTTP::Put.new(uri)
            request.body = body.to_json
            request['Content-Type'] = 'application/json'
          else
            STDERR.puts "Invalid HTTP method specified. Method: #{method}"
          end

          response = http.request(request)

          response.code.to_i
        rescue => e
          err_msg = "Failed to send response to CloudFormation pre-signed S3 URL. "\
          "Error Details: #{e} RC: #{response.code}"

          STDERR.puts err_msg
        end

        def success
          status_code = send_response('PUT', @response_url, provider_response(SUCCESS_STATUS))
          err_msg = "ERROR: Failed to send success message to CloudFormation pre-signed S3 URL. RC: #{status_code}"
          raise err_msg if status_code > 400
        end

        def failure
          status_code = send_response('PUT', @response_url, provider_response(FAILURE_STATUS))
          err_msg = "ERROR: Failed to send failure message to CloudFormation pre-signed S3 URL. RC: #{status_code}"
          raise err_msg if status_code > 400
        end

        private

        def provider_response(status, reason = '')
          {
            Status: status,
            Reason: reason.to_s,
            PhysicalResourceId: @request_id,
            StackId: @stack_id,
            RequestId: @request_id,
            LogicalResourceId: @logical_resource_id,
            Data: {
                Result: 'OK'
            }
          }
        end
      end
    end
  end
end