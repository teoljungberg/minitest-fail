module Minitest
  def self.plugin_fail_options opts, options
    opts.on "--fail", "Fail on an empty test" do
      Fail.fail!
    end
  end

  def self.plugin_fail_init options = {}
    if Fail.fail?
      filtered_reporters = self.reporter.reporters.dup
      filtered_reporters.reject! {|rep| rep.is_a? ProgressReporter }
      filtered_reporters.each    {|rep| rep.send :extend, Fail }
    end
  end

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
        empty_test = result.method(result.name).source_location
        e          = ::Minitest::Assertion.new "Empty test #{result}"

        e.class.send :attr_accessor, :location
        e.location = empty_test.join(":")

        result.failures << e
        self.results    << result
      end
    end
  end
end
