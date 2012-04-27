require File.expand_path(File.dirname(__FILE__) + "/../lib/grammoire")

grammar = Grammoire.define do
  rule(:conditionals, :condition => is { data(:variable) == 5 }) do
    'You got 5!'
  end
  rule(:conditionals, :condition => is { data(:variable) < 5 }) do
    'You got less then 5. :('
  end
  rule(:conditionals, :condition => is { data(:variable) > 5 }) do
    'You got more then 5. :)'
  end
  rule(:conditionals) { 'I am always valid.' }
end

puts grammar.produce(:conditionals, :variable => 5)
puts grammar.produce(:conditionals, :variable => 2)
8uts grammar.produce(:conditionals, :variable => 8)
