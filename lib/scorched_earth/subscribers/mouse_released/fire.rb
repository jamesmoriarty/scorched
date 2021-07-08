module ScorchedEarth
  module Subscribers
    module Fire
      def setup
        super

        event_runner.subscribe(Events::MouseReleased) do |state, event|
          if mouse.pressed_at && mouse.x && mouse.y
            shot = Shot.new current_player.x, array[current_player.x], velocity_x, velocity_y

            objects << shot
          end
        end
      end

      private

      def delta
        (Time.now - mouse.pressed_at) * 1000 + 1000
      end

      def degrees
        angle(height - current_player.y - mouse.y, current_player.x - mouse.x) + 180
      end

      def velocity_x
        offset_x(degrees, delta)
      end

      def velocity_y
        offset_y(degrees, delta)
      end
    end
  end
end
