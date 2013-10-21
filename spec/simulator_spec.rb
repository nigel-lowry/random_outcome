require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Simulator do

  context "p(A) = 10%, p(B) = 90%" do
    before :all do
      @simulator = Simulator.new(A: 0.1, B: 0.9)
    end

    subject { @simulator }

    it { should give_the_outcome(:A).with_the_probability(0.1) }
    it { should give_the_outcome(:B).with_the_probability(0.9) }
    it { should give_the_outcome(:C).with_the_probability(0.0) }
  end

  context "p(A) = 40%, p(B) = 60%" do
    before :all do
      @simulator = Simulator.new(A: 0.4, B: 0.6)
    end

    subject { @simulator }

    it { should give_the_outcome(:A).with_the_probability(0.4) }
    it { should give_the_outcome(:B).with_the_probability(0.6) }
  end

  context "p(A) = 10%, p(B) = 20%, p(C) = 70%" do
    before :all do
      @simulator = Simulator.new(A: 0.1, B: 0.2, C: 0.7)
    end

    subject { @simulator }

    it { should give_the_outcome(:A).with_the_probability(0.1) }
    it { should give_the_outcome(:B).with_the_probability(0.2) }
    it { should give_the_outcome(:C).with_the_probability(0.7) }
  end

  context "with no outcomes" do
    it "will raise error" do
      expect { Simulator.new({}) }.to raise_error
    end
  end

  context "with only one outcome" do
    it "will raise error" do
      expect { Simulator.new(A: 1.0) }.to raise_error
    end
  end

  context "with probabilities summing to less than 1.0" do
    it "will raise error" do
      expect { Simulator.new(A: 0.1, B: 0.89) }.to raise_error
    end
  end

  context "with probabilities summing to more than 1.0" do
    it "will raise error" do
      expect { Simulator.new(A: 0.1, B: 0.91) }.to raise_error
    end
  end

  context "with an impossible event" do
    it "will raise error" do
      expect { Simulator.new(A: 0.1, B: 0.9, C: 0.0) }.to raise_error
    end
  end
end
