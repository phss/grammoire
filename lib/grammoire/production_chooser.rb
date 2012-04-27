class ProductionChooser

  def initialize(random_generator = RandomGenerator.new)
    @random_generator = random_generator
  end

  def select_from(productions)
    return nil if productions.empty?

    selected_weight_index = @random_generator.number_up_to(total_weight_from(productions))
    max_weight_index = 0

    productions.each do |production|
      max_weight_index += production.weight
      return production if selected_weight_index < max_weight_index
    end
  end

 private

  def total_weight_from(productions)
    productions.inject(0) { |sum, production| sum + production.weight }
  end
  
end