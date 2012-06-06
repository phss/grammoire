module Grammoire
  class Rules

    def initialize
      @rules = []
    end

    def <<(rule)
      @rules << rule
    end

    def for(rule_name)
      matching_rules = @rules.select { |rule| rule.name == rule_name }

      raise GrammarError.new("Rule '#{rule_name}' doesn't exist.") if matching_rules.empty?

      return matching_rules 
    end
    
  end
end