require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Simulator do
  context "p(A) = 10%, p(B) = 90%" do
    before :all do
      @simulator = Simulator.new(a: 0.1, b: 0.9)
    end

    subject { @simulator }

    xit "should return A or B" do
      @simulator.outcome.should be
    end

    it "should return A roughly 10% of the time" do
      a_count = 0
      times = 1_000
      times.times do
        a_count += 1 if @simulator.outcome == :a
      end
      a_count.should eq 100
    end

    it "should happen B roughly 90% of the time" do
      b_count = 0
      times = 1_000
      times.times do
        b_count += 1 if @simulator.outcome == :b
      end
      b_count.should eq 900
    end

  end
end
