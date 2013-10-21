class Simulator # TODO rename file
  attr_reader :outcome_to_probability

  def initialize outcome_to_probability
    raise "don't have any outcomes" if outcome_to_probability.empty?
    raise "only have one outcome" if outcome_to_probability.size == 1
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
end