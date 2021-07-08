module ScorchedEarth
  module Subscribers
    module GameRender


      def setup
        super

        event_runner.subscribe(Events::GameRender) do |state, event|
          graphics = event.graphics

          graphics.set_color color_palette.get('sky')
          graphics.fill_rect 0, 0, width, height

          Renders::Mouse.new(mouse, current_player).call(graphics, color_palette)

          objects.each { |object| Renders.find(object).call(graphics, color_palette) }
          players.each { |player| Renders.find(player).call(graphics, color_palette) }

          Renders::Map.new(array).call(graphics, color_palette)
        end
      end
    end
  end
end
