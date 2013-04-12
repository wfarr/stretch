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

    private
    def get(*args)
    end
  end
end
