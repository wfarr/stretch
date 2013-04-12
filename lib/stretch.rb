require "stretch/client"
require "stretch/version"

module Stretch
  def self.index name = nil
    Client.new.index name
  end
end
