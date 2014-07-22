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
        e          = ::Minitest::Skip.new "Implement #{result.class}##{result.name}"

        redefine_method e.class, :location do
          -> { empty_test.join(":") }
        end

        result.failures << e
        self.results    << result
      end
    end

    private

    def redefine_method klass, method
      return unless block_given?

      klass.send :alias_method, "old_#{method}", method
      klass.send :define_method, method, yield
    end
  end
end
