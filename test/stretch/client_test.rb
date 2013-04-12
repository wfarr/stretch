require "test_helper"

require "stretch/client"

describe Stretch::Client do
  it "can be initialized" do
    assert described_class.new.is_a?(Stretch::Client)
  end

  it "can chain index" do
    instance = described_class.new

    assert_nil instance.index
    assert_equal "foo", instance.index("foo").index
  end
end
