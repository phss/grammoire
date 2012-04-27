class ProductionChooser

  def initialize(random_generator = RandomGenerator.new)
    @random_generator = random_generator
  end

  def select_from(productions)
    return nil if productions.empty?

    options = []
    productions.each do |production|
      production.weight.times { options << production }
    end

    return @random_generator.one_of(options)
  end
  
end