module Grammoire
  class Grammar

    def initialize(random_generator = RandomGenerator.new)
      @rules = {}
      @chooser = ProductionChooser.new(random_generator)
      context(EvaluationContext)
    end

    def context(context_class)
      @context = context_class.new(self)
    end
    
    def rule(name, options = {}, &action)
      @rules[name] ||= Rule.new    
      @rules[name] << Production.with_options(options, &action)
    end

    def rules_names
      @rules.keys
    end

    def produce(rule_name)
      raise GrammarError.new("Rule '#{rule_name}' doesn't exist in the grammar.") unless rules_names.include?(rule_name)
      
      return @chooser.select_from(production_rules_for(rule_name)).evaluate(@context)
    end

   private

    def production_rules_for(name)
      @rules[name].productions
    end

  end
end