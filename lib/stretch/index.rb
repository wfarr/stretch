module Stretch
  class Index
    attr_reader :name, :connection

    def initialize name, connection
      raise ArgumentError if name.nil? || name.empty?

      @name = name
      @connection = connection
    end

    def settings options = {}
      if options.any?
        put "/_settings", options
      else
        get("/_settings")[@name]["settings"]
      end
    end

    def open
      post "/_open"
    end

    def close
      post "/_close"
    end

    private
    def get path, options = {}
      @connection.request :get, "/#{@name}#{path}", options
    end

    def put path, options = {}
      @connection.request :put, "/#{@name}#{path}", options
    end

    def post path, options = {}
      @connection.request :post, "/#{@name}#{path}", options
    end
  end
end
