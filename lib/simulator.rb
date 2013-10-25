require 'active_support/all'

class Simulator

  def initialize outcome_to_probability
    raise_if_only_have_one_outcome(outcome_to_probability)
    raise_if_probabilities_total_isnt_one(outcome_to_probability)
    raise_if_have_any_impossible_outcomes(outcome_to_probability)
    @random_to_outcome = random_to_outcome outcome_to_probability
  end

  def outcome
    num = random_float_including_zero_and_excluding_one
    @random_to_outcome.detect {|probability_range, _| num.in? probability_range }.last
  end

private

  def raise_if_only_have_one_outcome(outcome_to_probability)
    raise "only have one outcome" unless outcome_to_probability.many?
  end

  def raise_if_probabilities_total_isnt_one(outcome_to_probability)
    raise "probabilities don't total one" unless outcome_to_probability.values.sum == 1.0
  end

  def raise_if_have_any_impossible_outcomes(outcome_to_probability)
    raise "have an impossible outcome" if outcome_to_probability.has_value? 0.0
  end

  def random_float_including_zero_and_excluding_one
    rand
  end

  def random_to_outcome(outcome_to_probability)
    # range to outcome
    lower_bound = 0.0
    new_map = {}

    outcome_to_probability.each do |outcome, probability|
      upper_bound = lower_bound + probability
      new_map.store lower_bound...upper_bound, outcome
      lower_bound = upper_bound
    end

    new_map
  end
end