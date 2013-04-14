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

  describe "#health" do
    let(:connection) { MiniTest::Mock.new }

    after do
      connection.verify
    end

    it "requires either a cluster scope or an index scope" do
      instance.stub :scope, { :cluster => false, :index => nil } do
        assert_raises Stretch::InvalidScope do
          instance.health
        end
      end
    end

    it "requests cluster health if the scope is cluster" do
      instance.stub :connection, connection do
        connection.expect :get, { "status" => "ok" }, %w(/_cluster/health)
        instance.cluster.health
      end
    end

    it "requests index health if the scope is an index" do
      instance.stub :connection, connection do
        connection.expect :get, { "status" => "ok" }, %w(/foo/health)
        instance.index("foo").health
      end
    end
  end

  describe "#state" do
    it "requires a cluster scope" do
      instance.stub :scope, { :cluster => false } do
        assert_raises Stretch::InvalidScope do
          instance.state
        end
      end
    end

    it "can return the state of a cluster" do
      instance.connection.stub :get, { "status" => "ok" } do
        assert_equal "ok", instance.cluster.state["status"]
      end
    end
  end
end
