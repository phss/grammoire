require File.expand_path(File.dirname(__FILE__) + "/../lib/grammoire")

class ArrayEvaluationContext < Grammoire::EvaluationContext
  def one_of(*productions)
    production = productions[rand(productions.size)] 
    evaluated_results =  production.collect do |element|
      if element.kind_of? Symbol
        eval(element)
      else
        element
      end
    end
    return evaluated_results.join
  end
end


grammar = Grammoire.define do
  context ArrayEvaluationContext

  rule(:s) { produce { one_of([:s, :s], ['(', :s, ')'], ['()']) } }
end

10.times { puts grammar.evaluate(:s) + "\n\n" }
