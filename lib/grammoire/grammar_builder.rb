module Grammoire
  
  class GrammarBuilder
    
    def initialize
      @rules = Rules.new 
      @context_class = EvaluationContext
    end

    def rule(rule_name, &rule_setup)
      @rules << Rule.new(rule_name, &rule_setup)
    end

    def context(context_class)
      @context_class = context_class
    end

    def build
      Grammar.new(@rules, @context_class)
    end

  end

end