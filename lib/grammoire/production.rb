module Grammoire
  class Production
    attr_reader :weight
    
    def initialize(weight, &action)
      @weight = weight
      @action = action
    end 

    def self.with_options(options, &action)
      options = {:weight => 1}.merge(options)
      
      return Production.new(options[:weight], &action)
    end

    def evaluate(context)
      context.instance_eval &@action
    end
    
  end
end