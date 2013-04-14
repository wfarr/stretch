require "test_helper"

require "stretch/connection"

describe Stretch::Connection do
  let(:instance) { described_class.new }
  let(:response) do
    Struct.new :response do
      def body
        MultiJson.dump({ "status" => "ok" })
      end

      def success?
        true
      end
    end.new
  end

  it "accepts get requests" do
    instance.connection.stub :get, response do
      instance.get "/foo"
    end
  end

  it "accepts post requests" do
    instance.connection.stub :post, response do
      instance.post "/foo"
    end
  end

  it "accepts put requests" do
    instance.connection.stub :put, response do
      instance.put "/foo"
    end
  end

  it "accepts delete requests" do
    instance.connection.stub :delete, response do
      instance.delete "/foo"
    end
  end
end
