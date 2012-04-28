require File.expand_path(File.dirname(__FILE__) + "/../lib/grammoire")

grammar = Grammoire.define do
  rule(:conditionals) do
    pre_condition { data(:variable) == 5 }
    produce {'You got 5!'}
  end
  rule(:conditionals) do
    pre_condition { data(:variable) < 5 }
    produce {'You got less then 5. :('}
  end
  rule(:conditionals) do
    pre_condition { data(:variable) > 5 }
    produce {'You got more then 5. :)'}
  end
  rule(:conditionals) { produce {'I am always valid.'} }
end

puts grammar.produce(:conditionals, :variable => 5)
puts grammar.produce(:conditionals, :variable => 2)
puts grammar.produce(:conditionals, :variable => 8)