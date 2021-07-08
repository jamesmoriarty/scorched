module ScorchedEarth
  module Subscribers
    module NextPlayer
      def setup
        super

        event_runner.subscribe(Events::MouseReleased) do |state, event|
          @players = players.rotate!
        end
      end
    end
  end
end
