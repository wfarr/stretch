require "test_helper"

require "stretch/index"

describe Stretch::Index do
  let(:connection) { MiniTest::Mock.new }
  let(:instance)   { described_class.new "foo", connection }

  describe "#initialize" do
    it "raises an ArgumentError if the index name is nil" do
      assert_raises ArgumentError do
        described_class.new nil, connection
      end
    end

    it "raises an ArgumentError if the index name is empty" do
      assert_raises ArgumentError do
        described_class.new "", connection
      end
    end

    it "sets the name and the connection" do
      connection.expect :==, true, [connection]

      assert_equal "foo", instance.name
      assert_equal connection, instance.connection

      connection.verify
    end
  end

  describe "#settings" do
    it "sends a put request if there are any options" do
      connection.expect :request,
        { "ok" => true },
        [:put, "/foo/_settings", { :foo => "bar" }]

      instance.settings :foo => "bar"

      connection.verify
    end

    it "sends a get request if there are no options" do
      connection.expect :request,
        { "foo" => "bar" },
        [:get, "/foo/_settings", {}]

      instance.settings

      connection.verify
    end
  end

  describe "#open" do
    it "sends a post request to open the index" do
      connection.expect :request,
        { "ok" => true },
        [:post, "/foo/_close", {}]

      instance.close

      connection.verify
    end
  end

  describe "#close" do
    it "sends a post request to close the index" do
      connection.expect :request,
        { "ok" => true },
        [:post, "/foo/_open", {}]

      instance.open

      connection.verify
    end
  end
end
