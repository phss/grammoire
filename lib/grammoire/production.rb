module Grammoire
  class Production
    
    def initialize(&action)
      @action = action
    end 

    def evaluate(context)
      context.instance_eval &@action
    end
    
  end
end