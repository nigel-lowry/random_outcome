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
      a_count_percentage = a_count / times.to_f
      a_count_percentage.should be_within(0.01).of(0.1)
    end

    it "should happen B roughly 90% of the time" do
      b_count = 0
      times = 1_000
      times.times do
        b_count += 1 if @simulator.outcome == :b
      end
      b_count_percentage = b_count / times.to_f
      b_count_percentage.should be_within(0.01).of(0.9)
    end

  end
end
