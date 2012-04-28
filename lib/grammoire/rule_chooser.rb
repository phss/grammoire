class RuleChooser

  def initialize(random_generator = RandomGenerator.new)
    @random_generator = random_generator
  end

  def select_from(rules)
    return nil if rules.empty?

    selected_weight_index = @random_generator.number_up_to(total_weight_from(rules))
    max_weight_index = 0

    rules.each do |rule|
      max_weight_index += rule.weight
      return rule if selected_weight_index < max_weight_index
    end
  end

 private

  def total_weight_from(rules)
    rules.inject(0) { |sum, rule| sum + rule.weight }
  end
  
end