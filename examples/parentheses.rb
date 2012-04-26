require File.expand_path(File.dirname(__FILE__) + "/../lib/grammoire")

# Repeated rules
grammar = Grammoire.define do
  rule(:s) { produce(:s) + produce(:s) }
  rule(:s) { "(#{produce(:s)})" }
  rule(:s) { '()' }
end

10.times { puts grammar.produce(:s) + "\n\n" }

# Rule with custom context to simplify rule definition
class ArrayEvaluationContext < Grammoire::EventContext
  def one_of(productions)
    production = productions[rand(productions.size)] 
    evaluated_results =  production.collect do |element|
      if element.kind_of? Symbol
        produce(element)
      else
        element
      end
    end
    return evaluated_results.join
  end
end


grammar = Grammoire.define do
  context ArrayEvaluationContext

  rule(:s) { one_of([:s, :s], ['(', :s, ')'], ['()']) }
end

10.times { puts grammar.produce(:s) + "\n\n" }
