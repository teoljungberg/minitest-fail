require 'minitest/fail'

module Minitest
  def self.plugin_fail_options opts, options
    opts.on "--fail", "Fail on an empty test" do
      Fail.fail!
    end
  end

  def self.plugin_fail_init options = {}
    if Fail.fail?
      filtered_reporters = self.reporter.reporters.dup
      filtered_reporters.reject! { |rep| rep.is_a? ProgressReporter }
      filtered_reporters.each    { |rep| rep.send :extend, Fail }
    end
  end
end
