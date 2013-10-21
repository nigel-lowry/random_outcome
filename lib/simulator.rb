require 'active_support/all'

class Simulator

  def initialize outcome_to_probability
    raise_if_only_have_one_outcome(outcome_to_probability)
    raise_if_probabilities_total_isnt_one(outcome_to_probability)
    raise_if_have_impossible_outcome(outcome_to_probability)
    @outcome_to_probability = outcome_to_probability
  end

  def outcome
    num = random_float_including_zero_and_excluding_one

    lower_bound = 0.0

    @outcome_to_probability.each do |outcome, probability|
      upper_bound = lower_bound + probability

      if num.in? lower_bound...upper_bound
        return outcome
      else
        lower_bound = upper_bound
      end
    end
  end

private

  def raise_if_only_have_one_outcome(outcome_to_probability)
    raise "only have one outcome" unless outcome_to_probability.many?
  end

  def raise_if_probabilities_total_isnt_one(outcome_to_probability)
    raise "probabilities don't total one" unless outcome_to_probability.values.sum == 1.0
  end

  def raise_if_have_impossible_outcome(outcome_to_probability)
    raise "have an impossible outcome" if outcome_to_probability.has_value? 0.0
  end

  def random_float_including_zero_and_excluding_one
    rand
  end
end