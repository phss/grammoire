module Grammoire
  class Grammar

    def initialize(random_generator = RandomGenerator.new)
      @rules = Rules.new
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
      @context.for_rule(rule_name)
      @context.with_data_points(data)

      return @chooser.select_from(rules_for(rule_name)).evaluate(@context)
    end

   private
   
    def rules_for(name)
      rules = @rules.for(name)
      rules = rules.select { |rule| rule.applies?(@context) }

      raise GrammarError.new("Rule '#{name}' doesn't exist in the grammar or don't have valid pre-conditions.") if rules.empty?

      return rules
    end

  end
end