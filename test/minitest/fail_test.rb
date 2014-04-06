require_relative 'test_case'
require 'minitest/fail'

module Minitest
  class FailTest < TestCase
    def test_fail_eh
      fail_off!
      refute Fail.fail?
    end

    def test_fail_bang
      activate_fail!
      assert Fail.fail?
    end
  end

  class FailIntegrationTest < TestCase
    def test_integration_represent_empty_tests_as_failures
      activate_fail!

      reporter.start
      reporter.record example_test.new(:test_empty).run
      reporter.report

      exp_error = %r(Empty test #<Class:(.*)>#test_empty)

      assert_match exp_error, io.string
    end

    def test_integration_fail_needs_to_be_activated
      fail_off!

      reporter.start
      reporter.record example_test.new(:test_empty).run
      reporter.report

      exp_error = %r(Empty test, #<Class:(.*)>#test_empty)

      refute_match exp_error, io.string
    end
  end
end
