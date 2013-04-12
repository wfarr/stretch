require "bundler/setup"

require "minitest/spec"
require "minitest/autorun"

class MiniTest::Spec
  def described_class
    @described_class ||= self.class.ancestors.select { |c|
      c.respond_to? :desc
    }[-2].desc
  end
end
