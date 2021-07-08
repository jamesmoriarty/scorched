module ScorchedEarth
  module Subscribers
    module MouseMoved
      def setup
        super

        event_runner.subscribe(Events::MouseMoved) do |state, event|
          @mouse = Mouse.new event.x, event.y, mouse.pressed_at
        end
      end
    end
  end
end
