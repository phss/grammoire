module Grammoire

  class EvaluationContext
    attr_reader :rule_name

    def initialize(grammar)
      @grammar = grammar
      for_evaluation(nil, {})
    end
    
    def for_evaluation(rule_name, data)
      @rule_name = rule_name
      @data = data
    end
    
    def data(name)
      raise GrammarError.new("Data point '#{name}' doesn't exist in the evaluation context.") unless @data.has_key? name

      return @data[name]
    end

    def eval(rule)
      @grammar.evaluate(rule, @data)
    end

  end
  
end