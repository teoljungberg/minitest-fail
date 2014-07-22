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
    def exp_error
      /You have skipped tests/
    end

    def run_tests
      reporter.start
      reporter.record example_test.new(:test_empty).run
      reporter.report
    end

    def test_integration_skips_empty_tests
      activate_fail!
      run_tests

      assert_match exp_error, io.string
    end

    def test_integration_fail_needs_to_be_activated
      fail_off!
      run_tests

      refute_match exp_error, io.string
    end
  end
end
