require "grammoire"

grammar = Grammoire.define do
  rule(:s) { produce(:s) + produce(:s) }
  rule(:s) { "(#{produce(:s)})" }
  rule(:s) { '()' }
end

10.times { puts grammar.produce(:s) }