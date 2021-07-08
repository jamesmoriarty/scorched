module ScorchedEarth
  module Subscribers
    module Delta
      def setup
        super

        event_runner.subscribe(Events::GameUpdate) do |state, event|
          @objects = objects.map { |object| object.update event.delta }.compact
        end
      end
    end
  end
end
