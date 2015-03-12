require 'bundler/setup'

require 'minitest/autorun'
require 'minitest/reporters'
MiniTest::Reporters.use!
require 'shoulda/context'
require 'mocha/setup'

require 'celluloid-marathon'

#Celluloid.task_class = Celluloid::TaskThread

module CelluloidHooks
  def before_setup
    super
    Celluloid.boot
    Celluloid.logger.level = Logger::INFO if Celluloid.logger
  end

  def after_teardown
    Celluloid.shutdown
    super
  end
end

module TestCelluloid
  class TestBase < Minitest::Test

  end
end
