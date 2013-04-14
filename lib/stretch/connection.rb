require "faraday"
require "faraday_middleware"
require "multi_json"

module Stretch
  class Connection
    attr_reader :connection

    REQUEST_METHODS = [ :get, :post, :put, :delete ].freeze

    def initialize options = {}
      @connection = Faraday.new(options) do |builder|
        builder.request :json

        builder.use FaradayMiddleware::FollowRedirects
        builder.use FaradayMiddleware::ParseJson, :content_type => /\bjson$/

        # not sure if we need this?
        #builder.adapter *adapter
      end
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
    def request method, path, options
      unless REQUEST_METHODS.member? method
        raise Stretch::UnsupportedRequestMethod, "#{method} is not supported!"
      end

      response = connection.send(method) do |request|
        request.headers["Accept"] = "application/json"
        request.path = path
      end

      if response.success?
        response.body
      else
        response.error!
      end
    end
  end
end
