require "faraday"
require "faraday_middleware"
require "multi_json"

module Stretch
  class Connection
    attr_reader :connection

    REQUEST_METHODS = [ :get, :post, :put, :delete ]

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
      response = request :get, path, options
    end

    def post path, options = {}
      response = request :post, path, options
    end

    def put path, options = {}
      response = request :put, path, options
    end

    def delete path, options = {}
      response = request :delete, path, options
    end

    private
    def request method, path, options = {}
      unless REQUEST_METHODS.member? method
        raise Stretch::UnsupportedRequestMethod, "#{method} is not supported!"
      end

      response = connection.send(method) do |request|
        request.url path, options
      end

      if response.success?
        response.body
      else
        response.error!
      end
    end
  end
end
