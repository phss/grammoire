class Grammar

  def initialize(random_generator = RandomGenerator.new)
    @rules = {}
    @random_generator = random_generator
  end
  
  def rule(name, &evaluation)
    @rules[name] ||= []    
    @rules[name] << evaluation
  end

  def rules_names
    @rules.keys
  end

  def produce(rule)
    raise GrammarError.new("Rule '#{rule}' doesn't exist in the grammar.") unless rules_names.include?(rule)

    rules = @rules[rule]
    selected_rule = rules[@random_generator.next(rules.size)]

    instance_eval &selected_rule
  end

end