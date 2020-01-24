# frozen_string_literal: true

require 'net/http'
require 'json'
require 'uri'

module AWS
  module CloudFormation
    class Helper
      # Handles sending a response to CloudFormation
      class Response
        # https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/crpg-ref-responses.html
        FAILURE_STATUS = 'FAILED'
        HTTP_MAX_RETRIES = 3
        SUCCESS_STATUS = 'SUCCESS'

        def initialize
          @http_retries = 1
        end

        def failure(reason = '')
          status_code = send_response('PUT', Event.instance.response_url, provider_response(FAILURE_STATUS, reason))
          err_msg = "Failed to send failure message to CloudFormation pre-signed S3 URL. RC: #{status_code}"
          raise err_msg if status_code > 400
        end

        def send_response(method, response_url, body = nil)
          uri = ::URI.parse(response_url)
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = (uri.scheme == 'https')
          request = http_request(method, uri, body)

          Helper.logger.debug("Sending #{method} request to URL #{response_url}...")
          response = http.request(request)

          Helper.logger.debug("HTTP Response: #{response.inspect}")
          response.code.to_i
        rescue StandardError => e
          err_msg = 'Failed to send response to CloudFormation pre-signed S3 URL. '\
          "(Attempt #{@http_retries} of #{HTTP_MAX_RETRIES}) Error Details: #{e}"
          Helper.logger.error(err_msg)
          retry if (@http_retries += 1) <= HTTP_MAX_RETRIES
          @http_retries = 1
          err_msg = 'Reached max retry attempts and failed to send message to CloudFormation pre-signed S3 URL.'
          Helper.logger.error(err_msg)
          raise e
        end

        def success(reason = '')
          status_code = send_response('PUT', Event.instance.response_url, provider_response(SUCCESS_STATUS, reason))
          err_msg = "Failed to send success message to CloudFormation pre-signed S3 URL. RC: #{status_code}"
          raise err_msg if status_code > 400
        end

        private

        def http_request(method, uri, body)
          case method.upcase
          when 'PUT'
            request = Net::HTTP::Put.new(uri)
            request.body = body.to_json
            request['Content-Type'] = 'application/json'
          else
            Helper.logger.error("Invalid HTTP method specified. Method: #{method}")
          end

          request
        end

        def physical_resource_id
          id = generate_physical_id
          id = Event.instance.physical_resource_id unless Event.instance.physical_resource_id.to_s.empty?
          id
        end

        def generate_physical_id
          random_string = 8.times.map { [*'0'..'9', *'a'..'z'].sample }.join
          "#{Event.instance.stack_id.split('/')[1]}_#{Event.instance.LogicalResourceId}_#{random_string}"
        end

        def provider_response(status, reason)
          {
            Status: status,
            Reason: reason.to_s,
            PhysicalResourceId: physical_resource_id,
            StackId: Event.instance.stack_id,
            RequestId: Event.instance.request_id,
            LogicalResourceId: Event.instance.logical_resource_id,
            Data: {
              Result: 'OK'
            }
          }
        end
      end
    end
  end
end
