module ScorchedEarth
  module Subscribers
    module Collisions
      def setup
        super

        event_runner.subscribe(Events::GameUpdate) do |state, event|
          objects
            .select   { |object| object.is_a? Shot }
            .select   { |object| array.fetch(object.x, 0) > object.y }
            .each     { |object| event_runner.publish Events::Hit.new(object, radius = 50) }
            .each     { |object| objects << object.trajectory }
            .each     { |object| objects.delete object }
        end
      end
    end
  end
end
