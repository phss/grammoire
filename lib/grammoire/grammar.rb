module Grammoire
  class Grammar

    def initialize(random_generator = RandomGenerator.new)
      @rules = {}
      @random_generator = random_generator
      @context = EvaluationContext.new(self)
    end
    
    def rule(name, &action)
      @rules[name] ||= Rule.new    
      @rules[name] << Production.new(&action)
    end

    def rules_names
      @rules.keys
    end

    def produce(rule_name)
      raise GrammarError.new("Rule '#{rule_name}' doesn't exist in the grammar.") unless rules_names.include?(rule_name)

      rule = rule_for(rule_name)
      
      return one_of(rule.productions).evaluate(@context)
    end

   private

    def rule_for(name)
      @rules[name]
    end

    def one_of(productions)
      productions[@random_generator.next(productions.size)]
    end

  end
end