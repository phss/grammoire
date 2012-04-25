class Rule

  def initialize
    @productions = []
  end
  
  def <<(production)
    @productions << production
  end

  def select_production(random_generator)
    @productions[random_generator.next(@productions.size)]
  end
 
end