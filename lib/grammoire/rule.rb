module Grammoire
  class Rule
    attr_reader :productions

    def initialize
      @productions = []
    end
    
    def <<(production)
      @productions << production
    end

  end
end