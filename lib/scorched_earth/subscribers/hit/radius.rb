require 'scorched_earth/events/hit'

module ScorchedEarth
  module Subscribers
    module Radius
      def setup
        super

        event_runner.subscribe(Events::Hit) do |state, event|
          if players.any? { |player| inside_radius? event.object.x - player.x, 0, event.radius }
            event_runner.publish Events::GameOver.new(Time.now + 0.25)
          end
        end
      end
    end
  end
end
