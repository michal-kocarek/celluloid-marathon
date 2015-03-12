module Celluloid
  module Marathon
    # Marathon actor may run indefinitely, e.g. process some tasks in the endless loop
    # and then finish gracefully all unfinished work before closing.
    #
    # You can attach finisher method to current actor. Method is run when actor is finishing.
    # Register the method using `finisher :method_name`.
    # Method is called with one argument telling whether actor is currently terminating (true) or just finishing (false).
    class SupervisionGroup < Celluloid::SupervisionGroup

      # Calls finish on each of the actors and returns when all actors have finished.
      #
      # @param [Integer] timeout How long to wait with the notification.
      # @return [self] For chaining
      def finish(timeout = nil)
        futures = []
        actors.each { |actor| futures << actor.future.finish(timeout=nil) }
        futures.each { |future| future.value }
        self
      end

    end
  end
end
