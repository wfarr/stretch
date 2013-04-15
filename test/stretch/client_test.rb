require "test_helper"

require "stretch/client"

describe Stretch::Client do
  let(:instance) { described_class.new }

  it "#index" do
    assert instance.index("foo").is_a?(Stretch::Index)
  end

  it "#cluster" do
    assert instance.cluster.is_a?(Stretch::Cluster)
  end
end
