require "grammoire"

grammar = Grammoire.define do
  rule :s => apply(:s) + apply(:s)
  rule :s => "(#{apply(:s)})"
  rule :s => '()' 
end

10.times { puts grammar.generate(:s) }