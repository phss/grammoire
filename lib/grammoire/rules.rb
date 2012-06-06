module Grammoire
  class Rules

    def initialize
      @rules = []
    end

    def <<(rule)
      @rules << rule
    end

    def applying_for(context)
      matching_rules = @rules.select { |rule| rule.applies?(context) }

      raise GrammarError.new("Rule '#{context.rule_name}' doesn't exist or don't have valid pre-conditions.") if matching_rules.empty?

      return matching_rules 
    end
    
  end
end