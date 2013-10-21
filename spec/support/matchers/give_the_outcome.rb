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

  failure_message_for_should do |actual|
    "expected that #{outcome} would occur with a probability of #{@percent}"
  end

  failure_message_for_should_not do |actual|
    "expected that #{outcome} would not occur with a probability of #{@percent}"
  end

  description do
    "occur with a probability of #{@percent}"
  end
end