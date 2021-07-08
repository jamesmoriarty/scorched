require 'scorched_earth/events/game_over'

module ScorchedEarth
  module Subscribers
    module Timeout
      def setup
        super

        event_runner.subscribe(Events::GameOver) do |state, event|
          event.time < Time.now ? setup : event_runner.publish(event)
        end
      end
    end
  end
end
