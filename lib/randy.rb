class Simulator # TODO rename file
  def initialize outcome_to_probability
    @outcome_to_probability = outcome_to_probability
  end

  def outcome
    first_key = @outcome_to_probability.keys.first
    if rand < @outcome_to_probability[first_key]
      first_key
    else
      @outcome_to_probability.keys.last
    end
  end
end