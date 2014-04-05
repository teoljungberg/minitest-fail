require 'minitest/autorun'
require 'stringio'

$:<< File.join(File.dirname(__FILE__), '../../lib')
require 'minitest/fail'

module Minitest
  class TestCase < Minitest::Test
    def io
      @io ||= StringIO.new ""
    end

    def example_test
      @example_test ||= Class.new(Minitest::Test) {
        def test_pass
          assert 1
        end

        def test_empty
        end
      }
    end

    private

    def fail_off!
      Fail.instance_variable_set("@fail", false)
    end

    def activate_fail!
      self.reporter.reporters.reject! { |rep| rep.is_a? ProgressReporter }
      self.reporter.reporters.each    { |rep| rep.send :extend, Fail }
    end
  end
end
