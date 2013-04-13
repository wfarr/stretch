require "test_helper"

require "stretch"

describe Stretch do
  describe ".index" do
    it "returns a client with the appropriate index" do
      stretch = Stretch.index('foo')

      assert stretch.is_a?(Stretch::Client)
      assert_equal "foo", stretch.scope[:index]
    end
  end
end
