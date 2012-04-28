module Grammoire
  class Rule
    attr_reader :name, :weight

    def initialize(name, &setup)
      @name = name
      weights(1)
      
      instance_eval &setup if block_given?
    end

    def weights(weight)
      @weight = weight
    end
   
    def produce(&action)
      @action = action
    end

    def evaluate(context)
      context.instance_eval &@action
    end

  end
end