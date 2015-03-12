require_relative '../test_helper'

module TestCelluloid
  class SupervisionGroupTest < Minitest::Test
    include CelluloidHooks
    include Celluloid::Marathon

    class TestActor < Actor
      finisher :my_finisher
      def initialize(call)
        @call = call
      end
      def endless_loop
        @call.running(registered_name)
        loop do
          # ... some code ...
          if finishing?
            @call.stopped(registered_name)
            break
          end
        end
      end
      def my_finisher
        @call.finish(registered_name)
      end
    end

    context 'Marathon supervision group' do

      should 'finish all actors' do
        call = mock('call')
        call.expects(:running).once.with(:'actor-1')
        call.expects(:running).once.with(:'actor-2')
        call.expects(:running).once.with(:'actor-3')

        call.expects(:stopped).times(3)

        call.expects(:finish).once.with(:'actor-1')
        call.expects(:finish).once.with(:'actor-2')
        call.expects(:finish).once.with(:'actor-3')

        group = SupervisionGroup.run!
        group.supervise_as 'actor-1', TestActor, call
        group.supervise_as 'actor-2', TestActor, call
        group.supervise_as 'actor-3', TestActor, call

        group.actors.each { |actor| actor.async.endless_loop }

        sleep(1)

        group.finish
        group.terminate
      end


    end
  end
end
