require "stretch/client"
require "stretch/version"

module Stretch
  class InvalidScope < StandardError; end
  class UnsupportedRequestMethod < StandardError; end

  def self.index name = nil
    Client.new.index name
  end
end
