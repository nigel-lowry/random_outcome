require 'active_support/all'

class Simulator

  def initialize outcome_to_probability
    raise_if_only_have_one_outcome(outcome_to_probability)
    raise_if_probabilities_total_isnt_one(outcome_to_probability)
    @outcome_to_probability = outcome_to_probability
  end

  def outcome
    num = rand

    first_key = @outcome_to_probability.keys[0]
    second_key = @outcome_to_probability.keys[1]
    third_key = @outcome_to_probability.keys[2]

    if num < @outcome_to_probability[first_key]
      first_key
    elsif num < @outcome_to_probability[first_key] + @outcome_to_probability[second_key]
      second_key
    elsif num < @outcome_to_probability[first_key] + @outcome_to_probability[second_key] + @outcome_to_probability[third_key]
      third_key
    end
  end

private

  def raise_if_only_have_one_outcome(outcome_to_probability)
    raise "only have one outcome" unless outcome_to_probability.many?
  end

  def raise_if_probabilities_total_isnt_one(outcome_to_probability)
    raise "probabilities don't total one" unless outcome_to_probability.values.sum == 1.0
  end
end