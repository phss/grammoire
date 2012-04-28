require File.expand_path(File.dirname(__FILE__) + "/../../lib/grammoire")

grammar = Grammoire.define do
  rule(:s) { produce { 'a' + eval(:s) }; weights 4 }
  rule(:s) { produce { 'b' + eval(:s) } }
  rule(:s) { produce { eval(:end) } }
  
  rule(:end) { produce { 'x' }; weights 10 }
  rule(:end) { produce { 'y' } }
end

10.times { puts grammar.evaluate(:s) + "\n\n" }
