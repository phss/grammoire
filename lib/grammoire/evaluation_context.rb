module Grammoire

  class EvaluationContext

    def initialize(grammar)
      @grammar = grammar
    end

    def produce(rule)
      @grammar.produce(rule)
    end
        
  end

end