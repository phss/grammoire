require File.expand_path(File.dirname(__FILE__) + "/../../lib/grammoire")

grammar = Grammoire.define do
  rule(:s) { produce { eval(:s) + eval(:s) } }
  rule(:s) { produce { "(#{eval(:s)})" } }
  rule(:s) { produce { '()' } }
  rule(:s) { produce { "[#{eval(:s)}]" } }
  rule(:s) { produce { '[]' } }
end

10.times { puts grammar.evaluate(:s) + "\n\n" }
