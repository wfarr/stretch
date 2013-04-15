require "stretch/connection"
require "stretch/cluster"
require "stretch/index"

module Stretch
  class Client
    def initialize options = {}
      self.tap do
        @connection = Stretch::Connection.new options
      end
    end

    def cluster
      Cluster.new @connection
    end

    def index name
      Index.new name, @connection
    end
  end
end
