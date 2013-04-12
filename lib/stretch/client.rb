module Stretch
  class Client
    @index = nil

    def index name = nil
      name.nil? ? @index : self.tap { @index = name }
    end
  end
end
