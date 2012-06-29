module Grammoire
  class Grammar

    def initialize(rules, context_class, random_generator = RandomGenerator.new)
      @rules = rules
      @chooser = RuleChooser.new(random_generator)
      @context = context_class.new(self)
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