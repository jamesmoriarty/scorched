require 'scorched_earth/events/hit'

module ScorchedEarth
  module Subscribers
    module Effect
      def setup
        super

        event_runner.subscribe(Events::Hit) do |state, event|
          objects << Explosion.new(event.object.x, event.object.y)
        end
      end
    end
  end
end
