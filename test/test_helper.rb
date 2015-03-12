require 'bundler/setup'

require 'minitest/autorun'
require 'minitest/reporters'
MiniTest::Reporters.use!
require 'shoulda/context'

require 'celluloid-marathon'

Celluloid.task_class = Celluloid::TaskThread

module CelluloidHooks
  def before_setup
    super
    Celluloid.boot
  end

  def after_teardown
    old_logger = Celluloid.logger
    Celluloid.logger = nil
    Celluloid.shutdown
    Celluloid.logger = old_logger
    super
  end
end

module TestCelluloid
  class TestBase < Minitest::Test

  end
end
