include Java

import java.awt.Color

require 'scorched_earth/objects/player'
require 'scorched_earth/objects/shot'
require 'scorched_earth/objects/explosion'
require 'scorched_earth/objects/mouse'
require 'scorched_earth/event_runner'
require 'scorched_earth/events/game_update'
require 'scorched_earth/events/game_render'
require 'scorched_earth/subscribers/game_over/timeout'
require 'scorched_earth/subscribers/game_update/collisions'
require 'scorched_earth/subscribers/game_update/delta'
require 'scorched_earth/subscribers/game_render'
require 'scorched_earth/subscribers/hit/deform'
require 'scorched_earth/subscribers/hit/effect'
require 'scorched_earth/subscribers/hit/radius'
require 'scorched_earth/subscribers/mouse_moved'
require 'scorched_earth/subscribers/mouse_pressed'
require 'scorched_earth/subscribers/mouse_released/fire'
require 'scorched_earth/subscribers/mouse_released/next_player'
require 'scorched_earth/helpers'
require 'scorched_earth/services/color_palette'
require 'scorched_earth/services/deform'
require 'scorched_earth/services/wave'
require 'scorched_earth/renders'

module ScorchedEarth
  class Game
    include Helpers

    Subscribers.constants.each { |name| prepend Subscribers.const_get name }

    attr_reader :width, :height, :mouse,
                :event_runner, :color_palette, :objects, :players, :array

    def initialize(width, height)
      @width  = width
      @height = height
      @mouse  = Mouse.new
    end

    def setup
      @color_palette = Services::ColorPalette.new Color::RED, Color::YELLOW, Color::WHITE
      @event_runner  = EventRunner.new
      @objects       = []
      @array         = Services::Wave.new(width, height, phases = rand(10)).each.to_a # Array.new(width) { height / 4 }
      @players       = Array.new(2) { x = rand(width); Player.new(x, array[x]) }
    end

    def update(delta)
      event_runner.publish Events::GameUpdate.new delta
      event_runner.process! nil
    end

    def render(graphics)
      event_runner.run nil, Events::GameRender.new(graphics)
    end

    def publish(event)
      event_runner.publish event
    end

    def current_player
      players.first
    end
  end
end
