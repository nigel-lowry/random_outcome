require 'active_support/all'

# Generates outcomes with specified probabilities
class Simulator

  # creates a new Simulator which will return the desired outcomes with the given probability
  # @param outcome_to_probability [Hash<Symbol, Number>] hash of outcomes to their probability (represented as
  #   numbers between zero and one)
  # @note raises errors if there is only one possible outcome (why bother using this if there's only one
  #   outcome?), if the probabilities don't total one (use Rationals if this proves problematic with rounding) or
  #   if any of the outcomes are impossible (why include them if they can never happen?)
  def initialize outcome_to_probability
    raise_if_dont_have_many_outcomes outcome_to_probability
    raise_if_probabilities_total_isnt_one outcome_to_probability
    raise_if_have_any_impossible_outcomes outcome_to_probability
    raise_if_have_any_negative_probabilities outcome_to_probability
    @probability_range_to_outcome = probability_range_to_outcome outcome_to_probability
  end

  # generate an outcome with the initialised probabilities
  # @return [Symbol] symbol for outcome
  def outcome
    num = random_float_including_zero_and_excluding_one # don't inline
    @probability_range_to_outcome.detect {|probability_range, _| num.in? probability_range }.last
  end

private

  def raise_if_dont_have_many_outcomes outcome_to_probability
    raise 'needs many outcomes' unless outcome_to_probability.many?
  end

  def raise_if_probabilities_total_isnt_one outcome_to_probability
    raise "probabilities don't total one" unless outcome_to_probability.values.sum == 1.0
  end

  def raise_if_have_any_impossible_outcomes outcome_to_probability
    raise 'have an impossible outcome' if outcome_to_probability.has_value? 0.0
  end

  def raise_if_have_any_negative_probabilities outcome_to_probability
    raise 'have negative probability' if outcome_to_probability.values.any? {|probability| probability < 0.0 }
  end

  def random_float_including_zero_and_excluding_one
    rand
  end

  def probability_range_to_outcome outcome_to_probability
    range_to_outcome = {}
    lower_bound = 0.0

    outcome_to_probability.each do |outcome, probability|
      upper_bound = lower_bound + probability
      range_to_outcome.store lower_bound...upper_bound, outcome
      lower_bound = upper_bound
    end

    range_to_outcome
  end
end