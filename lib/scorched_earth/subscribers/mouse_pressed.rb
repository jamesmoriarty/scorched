module ScorchedEarth
  module Subscribers
    module MousePressed
      def setup
        super

        event_runner.subscribe(Events::MousePressed) do |state, event|
          @mouse = Mouse.new mouse.x, mouse.y, Time.now
        end
      end
    end
  end
end
