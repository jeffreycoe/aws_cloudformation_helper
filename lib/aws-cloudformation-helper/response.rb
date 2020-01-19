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

        def failure(reason = '')
          status_code = send_response('PUT', event.response_url, provider_response(FAILURE_STATUS, reason))
          err_msg = "Failed to send failure message to CloudFormation pre-signed S3 URL. RC: #{status_code}"
          raise err_msg if status_code > 400
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
            logger.error("Invalid HTTP method specified. Method: #{method}")
          end

          response = http.request(request)

          response.code.to_i
        rescue => e
          err_msg = "Failed to send response to CloudFormation pre-signed S3 URL. Error Details: #{e}"

          logger.error(err_msg)
          raise e
        end

        def success(reason = '')
          status_code = send_response('PUT', event.response_url, provider_response(SUCCESS_STATUS, reason))
          err_msg = "Failed to send success message to CloudFormation pre-signed S3 URL. RC: #{status_code}"
          raise err_msg if status_code > 400
        end

        private

        def provider_response(status, reason)
          {
            Status: status,
            Reason: reason.to_s,
            PhysicalResourceId: event.request_id,
            StackId: event.stack_id,
            RequestId: event.request_id,
            LogicalResourceId: event.logical_resource_id,
            Data: {
                Result: 'OK'
            }
          }
        end
      end
    end
  end
end