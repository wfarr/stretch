require "stretch/connection"
require "stretch/uri_builder"

module Stretch
  class Client
    attr_reader :connection, :scope

    def initialize options = {}
      @index = nil
      @scope = {}
      @connection = Stretch::Connection.new options
    end

    def index name = nil
      if name.nil?
        @index
      else
        self.tap do
          @index = name
          @scope[:index] = name
        end
      end
    end

    def health
      if @index.nil?
        raise InvalidScopeError,
          "Health requires either cluster or an index"
      else
        get @scope, "/health"
      end
    end

    private
    def get(scope, path, options = {})
      response = connection.get Stretch::URIBuilder.build(scope, path, options)

      if response.success?
        response.parsed_body
      else
        response.error!
      end
    end
  end
end
