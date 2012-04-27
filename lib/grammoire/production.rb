module Grammoire
  class Production
    attr_reader :weight
    
    def initialize(weight, &action)
      @weight = weight
      @action = action
    end 

    def evaluate(context)
      context.instance_eval &@action
    end
    
  end
end