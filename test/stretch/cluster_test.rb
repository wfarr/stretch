require "test_helper"

require "stretch/cluster"

describe Stretch::Cluster do
  let(:connection) { MiniTest::Mock.new }
  let(:instance)   { described_class.new connection }

  describe "#initialize" do
    it "assigns connection" do
      connection.expect :==, true, [connection]

      assert_equal connection, described_class.new(connection).connection
    end
  end

  describe "#health" do
    it "sends a get request for health with options" do
      connection.expect :request,
        { "status" => "ok" },
        [:get, "/_cluster/health", { :timeout => "2s" }]

      instance.health :timeout => "2s"

      connection.verify
    end

    describe "with indices option" do
      it "sends a get request for indices health with correct level" do
        connection.expect :request,
          { "indices" => { "foo" => {}, "bar" => {} } },
          [:get, "/_cluster/health/foo,bar", { :level => "indices", :timeout => "2s" }]

        instance.health :indices => ["foo", "bar"], :timeout => "2s"

        connection.verify
      end
    end
  end

  describe "#state" do
    it "sends a get request for the state of the cluster" do
      connection.expect :request,
        { "nodes" => [1,2,3], "metadata" => { "foo" => "bar" }},
        [:get, "/_cluster/state", { :filter_routing_table => true }]

      instance.state :filter_routing_table => true

      connection.verify
    end
  end

  describe "#settings" do
    it "sends a put request if there are any options" do
      connection.expect :request,
        { "ok" => true },
        [:put, "/_cluster/settings", { :foo => "bar" }]

      instance.settings :foo => "bar"

      connection.verify
    end

    it "sends a get request if there are no options" do
      connection.expect :request,
        { "foo" => "bar" },
        [:get, "/_cluster/settings", {}]

      instance.settings

      connection.verify
    end
  end
end
