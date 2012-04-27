class ProductionChooser

  def initialize(random_generator = RandomGenerator.new)
    @random_generator = random_generator
  end

  def select_from(productions)
    return nil if productions.empty?

    options = []
    productions.each do |production|
      options << [production] * production.weight
    end
    options.flatten!

    return @random_generator.one_of(options)
  end
  
end