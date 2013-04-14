require "faraday"
require "multi_json"

module Stretch
  class Connection
    attr_reader :connection

    REQUEST_METHODS = [ :get, :post, :put, :delete ].freeze

    def initialize options = {}
      @connection = Faraday.new(options)
    end

    def get path, options = {}
      request :get, path, options
    end

    def post path, options = {}
      request :post, path, options
    end

    def put path, options = {}
      request :put, path, options
    end

    def delete path, options = {}
      request :delete, path, options
    end

    private
    def request method, path, options = {}
      validate_request_method method

      response = connection.send(method) do |request|
        request.headers["Accept"] = "application/json"
        request.path = path

        case method
        when :get
          options.each { |k,v| request.params[k] = v }
        when :post, :put
          request.body = MultiJson.dump(options)
        end
      end

      handle_response response
    end

    def validate_request_method method
      unless REQUEST_METHODS.member? method
        raise Stretch::UnsupportedRequestMethod, "#{method} is not supported!"
      end
    end

    def handle_response response
      if response.success?
        if response.body.empty?
          request :get, path
        else
          MultiJson.load response.body
        end
      else
        response.error!
      end
    end
  end
end
