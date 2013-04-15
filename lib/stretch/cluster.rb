module Stretch
  class Cluster
    attr_reader :connection

    def initialize connection
      @connection = connection
    end

    def health options = {}
      indices = options.delete(:indices) if options.has_key? :indices

      path = "/health"

      if indices
        path << "/#{[indices].flatten.join(',')}"
        options[:level] = "indices"
      end

      get path, options
    end

    def state options = {}
      get "/state", options
    end

    def settings options = {}
      if options.any?
        put "/settings", options
      else
        get "/settings"
      end
    end

    private
    def get path, options = {}
      @connection.request :get, "/_cluster#{path}", options
    end

    def put path, options = {}
      @connection.request :put, "/_cluster#{path}", options
    end
  end
end
