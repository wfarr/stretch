require "test_helper"

require "stretch/client"

describe Stretch::Client do
  let(:instance) { described_class.new }
  describe ".new" do
    describe "scope defaults" do
      it "index to nil" do
        assert_nil instance.scope[:index]
      end

      it "cluster to false" do
        refute instance.scope[:cluster]
      end
    end
  end

  it "can chain index" do
    assert instance.index("foo").is_a?(Stretch::Client)
    assert_equal "foo", instance.scope[:index]
  end

  it "can chain cluster" do
    assert instance.cluster.is_a?(Stretch::Client)
    assert instance.scope[:cluster]
  end

  it "can return the health of an index" do
    instance.stub :index, nil do
      assert_raises Stretch::InvalidScope do
        instance.health
      end
    end

    instance.connection.stub :get, { "status" => "ok" } do
      assert_equal "ok", instance.index("foo").health["status"]
    end
  end
end
