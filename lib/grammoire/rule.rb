module Grammoire
  class Rule
    attr_reader :name, :weight

    def initialize(name, &setup)
      @name = name
      weights(1)
      pre_condition { true }
      
      instance_eval &setup if block_given?
    end

    def weights(weight)
      @weight = weight
    end

    def pre_condition(&condition)
      @condition = condition 
    end

    def applies?(context)
      return false unless context.rule_name == @name
      context.instance_eval &@condition
    end
   
    def produce(&action)
      @action = action
    end

    def evaluate(context)
      context.instance_eval &@action
    end

  end
end