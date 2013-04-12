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

  it "can return the health of an index" do
    instance = described_class.new

    instance.stub :index, nil do
      assert_raises StandardError do
        instance.health
      end
    end

    instance.stub :get, { "status" => "ok" } do
      assert_equal "ok", instance.index("foo").health["status"]
    end
  end
end
