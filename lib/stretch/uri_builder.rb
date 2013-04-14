module Stretch
  class URIBuilder
    def self.build_from_scope scope, path
      if scope[:cluster]
        "/_cluster/#{path}"
      elsif scope[:index]
        "/#{scope[:index]}/#{path}"
      end
    end
  end
end
