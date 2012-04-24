class Grammar

  def initialize
    @rules = {}
  end
  
  def rule(name, &evaluation)
    @rules[name] = evaluation
  end

  def rules_names
    @rules.keys
  end

  def produce(rule)
    raise GrammarError.new("Rule '#{rule}' doesn't exist in the grammar.") unless rules_names.include?(rule)

    instance_eval &@rules[rule]
  end

end