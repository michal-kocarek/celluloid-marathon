module Celluloid
  module Marathon
    # Marathon actor may run indefinitely, e.g. process some tasks in the endless loop
    # and then finish gracefully all unfinished work before closing.
    #
    # You can attach finisher method to current actor. Method is run when actor is finishing.
    # Register the method using `finisher :method_name`.
    # Method is called with one argument telling whether actor is currently terminating (true) or just finishing (false).
    class Actor
      include Celluloid

      finalizer :__finalizer
      property :finisher

      # Let actor gracefully finish and wait till it finishes.
      #
      # All finishers are executed before method returns.
      #
      # @raise [Celluloid::TimeoutError] When timeout raises
      def finish(timeout = nil)
        return if @finishing

        @finishing = true
        future.__call_finisher(false).value(timeout)
      end

      # Tells that actor is finishing and should finish all work as soon as possible.
      #
      # @return [Boolean] True if work should end as soon as possible.
      def finishing?
        unless @finishing
          # Let Celluloid process messages by waiting to resolve a future.
          Future::new { 'dummy' }.value
        end

        @finishing
      end

      # Celluloid Finalizer
      def __finalizer
        unless @finishing
          @finishing = true
          __call_finisher true
        end
      end

      # Calls finisher defined by `finisher :method`.
      def __call_finisher(terminating = false)
        send(self.class.finisher) if self.class.finisher
      end

    end
  end
end
