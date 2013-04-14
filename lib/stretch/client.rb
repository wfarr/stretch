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

    # Chainable methods
    def cluster
      self.tap do
        scope[:cluster] = true
        scope[:index] = nil
      end
    end

    def index name
      self.tap do
        scope[:cluster] = false
        scope[:index]   = name
      end
    end

    # End points
    def health options = {}
      if scope[:index] || scope[:cluster]
        connection.get build_path("/health"), options
      else
        raise InvalidScope, "Health requires a cluster or index level scope"
      end
    end

    def state options = {}
      if @scope[:cluster]
        connection.get build_path("/state"), options
      else
        raise InvalidScope, "State requires a cluster level scope"
      end
    end

    def settings options = {}
      if @scope[:index] || @scope[:cluster]
        if options.any?
          connection.put build_path("/settings"), options
        else
          connection.get build_path("/settings")
        end
      else
        raise InvalidScope, "Settings requires a cluster or index level scope"
      end
    end

    private
    def build_path path
      Stretch::URIBuilder.build_from_scope scope, path
    end
  end
end
