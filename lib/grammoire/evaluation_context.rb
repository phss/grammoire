module Grammoire

  class EvaluationContext
    attr_reader :rule_name

    def initialize(grammar)
      @grammar = grammar
      with_data_points({})
    end
    
    def with_data_points(data)
      @data = data
    end
    
    def data(name)
      raise GrammarError.new("Data point '#{name}' doesn't exist in the evaluation context.") unless @data.has_key? name

      return @data[name]
    end

    def for_rule(rule_name)
      @rule_name = rule_name
    end

    def eval(rule)
      @grammar.evaluate(rule, @data)
    end

  end
  
end