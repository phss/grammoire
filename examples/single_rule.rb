require File.expand_path(File.dirname(__FILE__) + "/../lib/grammoire")

grammar = Grammoire.define do
  rule(:s) { produce(:s) + produce(:s) }
  rule(:s) { "(#{produce(:s)})" }
  rule(:s) { '()' }
  rule(:s) { "[#{produce(:s)}]" }
  rule(:s) { '[]' }
end

10.times { puts grammar.produce(:s) + "\n\n" }
