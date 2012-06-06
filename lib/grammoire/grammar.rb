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
      @context.for_evaluation(rule_name, data)

      return @chooser.select_from(rules_for(rule_name)).evaluate(@context)
    end

   private
   
    def rules_for(name)
      @rules.applying_for(@context)
    end

  end
end