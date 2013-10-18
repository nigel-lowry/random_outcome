require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Simulator do

  RSpec::Matchers.define :give_the_outcome do |outcome|
    match do |actual|
      outcome_count = 0
      trials = 10_000
      trials.times do
        outcome_count += 1 if actual.outcome == outcome
      end
      outcome_percentage = outcome_count / trials.to_f
      outcome_percentage.should be_within(0.01).of(@percent)
    end

    chain :with_the_percentage do |percent|
      @percent = percent
    end
  end

  context "p(A) = 10%, p(B) = 90%" do
    before :all do
      @simulator = Simulator.new(a: 0.1, b: 0.9)
    end

    subject { @simulator }

    xit "should return A or B" do
      @simulator.outcome.should be
    end

    it { should give_the_outcome(:a).with_the_percentage(0.1) }
    it { should give_the_outcome(:b).with_the_percentage(0.9) }
    it { should give_the_outcome(:c).with_the_percentage(0.0) }
  end
end
