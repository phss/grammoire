require File.expand_path(File.dirname(__FILE__) + "/../../lib/grammoire")

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

[5, 2, 8].each do |number|
  puts "Variable #{number} gives #{grammar.evaluate(:conditionals, :variable => number)}"
end
