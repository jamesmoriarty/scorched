module ScorchedEarth
  class EventRunner
    attr_reader :queue, :subscribers

    def initialize
      @queue       = Queue.new
      @subscribers = []
    end

    def publish(event)
      queue << event
    end

    def subscribe(klass, &block)
      subscribers << [klass, block]
    end

    def run(state, event)
      subscribers
        .select        { |klass, block| event.is_a? klass }
        .inject(state) { |state, (klass, block)| block.call state, event }
    end

    def process!(state)
      processing = Array.new(queue.size) { queue.pop }

      processing.inject(state) do |state, event|
        run state, event
      end
    end
  end
end
