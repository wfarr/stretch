require "faraday"
require "faraday_middleware"
require "multi_json"

module Stretch
  class Connection
    attr_reader :connection

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
      response = connection.request :get, path, options
    end

    private
    def request method, path, options = {}
      response = connection.some_stuff

      if response.success?
        response.parsed_body
      else
        response.error!
      end
    end
  end
end
