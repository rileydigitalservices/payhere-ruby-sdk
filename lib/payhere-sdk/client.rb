# frozen_string_literal: true

# Base implementation of the Payhere API client

# Includes methods common to inpayments, outpayments

require 'faraday'

require 'payhere-sdk/config'
require 'payhere-sdk/errors'

module Payhere
  class Client
    def send_request(method, path, body = {})
      begin
        conn = create_connection
        relative_path = "/api/#{Payhere.config.version}#{path}"

        case method
          when 'get'
            response = conn.get(relative_path)
          when 'post'
            response = conn.post(relative_path, body.to_json)
        end
      rescue ArgumentError
        raise "Missing configuration key(s)"
      end
      interpret_response(response)
    end

    def interpret_response(resp)
      body = resp.body.empty? ? '' : JSON.parse(resp.body)

      response = {
        body: body,
        code: resp.status
      }
      unless resp.status >= 200 && resp.status < 300
        handle_error(response[:body], response[:code])
      end

      body
    end

    def handle_error(response_body, response_code)
      raise Payhere::Error.new(response_body, response_code)
    end

    # set authorization and authentication
    def create_connection
      url = "https://api.payhere.africa" if Payhere.config.environment.eql?"production"
      url = "https://api-sandbox.payhere.africa/api" if Payhere.config.environment.eql?"sandbox"
      
      headers = {
        "Content-Type": 'application/json'
      }

      conn = Faraday.new(url: url)
      conn.headers = headers

      get_credentials
      conn.basic_auth(@username, @password)

      conn
    end

    def get_credentials
      @username = Payhere.config.username
      @password = Payhere.config.password
    end

    # retrieve transaction information
    def get_transaction_status(path)
      send_request('get', path)
    end
  end
end
