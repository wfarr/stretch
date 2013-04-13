module Stretch
  class Client
    @index = nil

    def index name = nil
      name.nil? ? @index : self.tap { @index = name }
    end

    def health
      if @index.nil?
        raise InvalidScopeError,
          "Health requires either cluster or an index"
      else
        get @scope, :health
      end
    end

    def connection
    end

    private
    def get(*args)
      response = connection.get *args

      if response.success?
        response
      else
        response.error!
      end
    end
  end
end
