require "stretch/client"
require "stretch/version"

module Stretch
  class InvalidScopeError < StandardError; end

  def self.index name = nil
    Client.new.index name
  end
end
