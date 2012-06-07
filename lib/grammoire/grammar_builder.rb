module Grammoire
  
  class GrammarBuilder
    
    def initialize
      @rules = Rules.new 
    end

    def rule(rule_name, &rule_setup)
      @rules << Rule.new(rule_name, &rule_setup)
    end

    def build
      Grammar.new(@rules)
    end

  end

end