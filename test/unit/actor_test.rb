require_relative '../test_helper'

module TestCelluloid
  class ActorTest < Minitest::Test
    include CelluloidHooks
    include Celluloid::Marathon

    class TestActorWithoutCheck < Actor
      def endless_loop
        loop do
          # ... some code ...
        end
      end
    end

    class TestActor < Actor
      def endless_loop
        loop do
          # ... some code ...
          break if finishing?
        end
      end
    end

    class TestActorWithFinisher < Actor
      finisher :my_finisher
      attr_accessor :finisher_status

      def endless_loop
        loop do
          # ... some code ...
          break if finishing?
        end
      end

      def my_finisher
        @finisher_status = 'called'
      end
    end

    context 'Marathon actor' do
      should 'raise error when terminating atomic process' do
        actor = TestActorWithoutCheck.new
        actor.async.endless_loop
        sleep(1)

        Celluloid.shutdown_timeout = 1

        Celluloid::Logger.expects(:error).with("Couldn't cleanly terminate all actors in 1 seconds!")
        Celluloid.shutdown
      end

      should 'finish gracefully when notified' do
        actor = TestActor.new
        actor.async.endless_loop

        sleep(1)

        actor.finish

        Celluloid.logger.expects(:error).never
        Celluloid.shutdown
      end

      should 'call finisher when finished' do
        actor = TestActorWithFinisher.new

        actor.async.endless_loop

        sleep(1)

        assert_equal nil, actor.finisher_status
        actor.finish
        assert_equal 'called', actor.finisher_status
      end

      should 'call finisher when finalized' do
        actor = TestActorWithFinisher.new

        actor.async.endless_loop

        sleep(1)

        Celluloid.shutdown_timeout = 1

        Celluloid.logger.expects(:warn).with{|arg| arg.match(/Terminating task/)}
        Celluloid.shutdown
      end

      should 'finish successfully when nothing is running' do
        actor = TestActor.new
        actor.finish
      end
    end
  end
end
