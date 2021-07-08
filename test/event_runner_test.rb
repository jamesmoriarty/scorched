require 'test_helper'

describe ScorchedEarth::EventRunner do
  let(:runner) { ScorchedEarth::EventRunner.new }
  let(:event)  { TestEvent }

  describe "#run" do
    specify "calls matching subscribers" do
      yielded = []
      func    = Proc.new { |e| yielded << e }

      runner.subscribe event, &func
      runner.run 42, event.new

      assert_equal [42], yielded
    end
  end
end
