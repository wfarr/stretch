require "test_helper"

require "stretch"

describe Stretch do
  describe ".index" do
    it "returns a client with the appropriate index" do
      assert_nil Stretch.index

      stretch = Stretch.index('foo')

      assert stretch.is_a?(Stretch::Client)
      assert_equal "foo", stretch.index
    end
  end
end
