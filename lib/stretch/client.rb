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
        connection.get Stretch::URIBuilder.build_from_scope(@scope, "/health")
      end
    end
  end
end
