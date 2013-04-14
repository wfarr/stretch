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
      with_scopes :cluster, :index do
        connection.get build_path("/health"), options
      end
    end

    def state options = {}
      with_scopes :cluster do
        connection.get build_path("/state"), options
      end
    end

    def settings options = {}
      with_scopes :cluster, :index do
        if options.any?
          connection.put build_path("/settings"), options
        else
          connection.get build_path("/settings")
        end
      end
    end

    def open!
      with_scopes :index do
        connection.post build_path("/_open")
      end
    end

    def close!
      with_scopes :index do
        connection.post build_path("/_close")
      end
    end

    private
    def build_path path
      Stretch::URIBuilder.build_from_scope scope, path
    end

    def with_scopes *scopes, &block
      if scopes.any? {|s| scope.has_key?(s) && scope[s] }
        yield
      else
        raise InvalidScope,
          "Requires one of the following scopes: #{scopes.inspect}. #{scope.inspect} given."
      end
    end
  end
end
