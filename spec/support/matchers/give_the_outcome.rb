RSpec::Matchers.define :give_the_outcome do |outcome|
  match do |actual|
    outcome_count = 0

    10_000.times do
      outcome_count += 1 if actual.outcome == outcome
    end

    (outcome_count / 10_000.to_f).should be_within(0.01).of(@probability)
  end

  chain :with_the_probability do |probability|
    @probability = probability
  end

  failure_message_for_should do |actual|
    "expected that #{outcome} would occur with a probability of #{@probability}"
  end

  failure_message_for_should_not do |actual|
    "expected that #{outcome} would not occur with a probability of #{@probability}"
  end

  description do
    "occur with a probability of #{@probability}"
  end
end