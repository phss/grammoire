module Grammoire
  class Grammar

    def initialize(random_generator = RandomGenerator.new)
      @rules = []
      @chooser = RuleChooser.new(random_generator)
      context(EvaluationContext)
    end

    def context(context_class)
      @context = context_class.new(self)
    end
    
    def rule(name, &action)
      @rules << Rule.new(name, &action)
    end

    def evaluate(rule_name, data = {})
      @context.with_data_points(data)

      rules = rules_for(rule_name)

      raise GrammarError.new("Rule '#{rule_name}' doesn't exist in the grammar.") if rules.empty?
      
      return @chooser.select_from(rules).evaluate(@context)
    end

   private
   
    def rules_for(name)
      @rules.select { |rule| rule.name == name && rule.applies?(@context) }
    end

  end
end