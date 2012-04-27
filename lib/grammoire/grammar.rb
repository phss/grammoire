module Grammoire
  class Grammar

    def initialize(random_generator = RandomGenerator.new)
      @rules = {}
      @random_generator = random_generator
      context(EvaluationContext)
    end

    def context(context_class)
      @context = context_class.new(self)
    end
    
    def rule(name, options = {}, &action)
      @rules[name] ||= Rule.new    
      @rules[name] << Production.with_options(options, &action)
    end

    def rules_names
      @rules.keys
    end

    def produce(rule_name)
      raise GrammarError.new("Rule '#{rule_name}' doesn't exist in the grammar.") unless rules_names.include?(rule_name)

      rule = rule_for(rule_name)
      
      return one_of(rule.productions).evaluate(@context)
    end

   private

    def rule_for(name)
      @rules[name]
    end

    def one_of(productions)
      options = []
      productions.each do |production|
        production.weight.times { options << production }
      end

      return options[@random_generator.next(options.size)]
    end

  end
end