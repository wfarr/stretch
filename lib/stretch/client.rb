require "stretch/connection"
require "stretch/uri_builder"

module Stretch
  class Client
    attr_reader :connection, :scope

    def initialize options = {}
      self.tap do
        @scope = {
          :cluster => false,
          :index   => nil
        }

        @connection = Stretch::Connection.new options
      end
    end

    def cluster
      self.tap do
        @scope[:cluster] = true
        @scope[:index] = nil
      end
    end

    def index name
      self.tap do
        @scope[:cluster] = false
        @scope[:index]   = name
      end
    end

    def health
      if @scope[:index].nil? && !@scope[:cluster]
        raise InvalidScope, "Health requires either cluster or an index"
      else
        connection.get Stretch::URIBuilder.build_from_scope(@scope, "/health")
      end
    end
  end
end
