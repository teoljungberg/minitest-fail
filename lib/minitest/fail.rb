require 'minitest'

module Minitest
  module Fail
    def self.fail!
      @fail = true
    end

    def self.fail?
      @fail ||= false
    end

    def record result
      super
      if result.assertions.zero?
        e = ::Minitest::Assertion.new "Empty test #{result}"
        e.class.send :attr_accessor, :location
        empty_test = result.method(result.name).source_location
        e.location = empty_test.join(":")
        result.failures << e
        self.results << result
      end
    end
  end
end
