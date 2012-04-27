module Grammoire

  class EvaluationContext

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
        
    def produce(rule)
      @grammar.produce(rule, @data)
    end

  end
  
end