module Stretch
  class Client
    def initialize
      @index = nil
      @scope = {}
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

    def connection
    end

    private
    def get(scope, path, options = {})
      response = connection.get URIBuilder.build(scope, path, options)

      if response.success?
        response.parsed_body
      else
        response.error!
      end
    end
  end
end
