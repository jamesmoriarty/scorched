require 'scorched_earth/events/hit'

module ScorchedEarth
  module Subscribers
    module Deform
      def setup
        super

        event_runner.subscribe(Events::Hit) do |state, event|
          if event.object.x < array.size && event.object.x > 0
            @array = Services::Deform.new(array).call(event.object.x, event.radius)
            @players = players.map { |player| Player.new player.x, array[player.x] }
          end
        end
      end
    end
  end
end
