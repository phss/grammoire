require File.expand_path(File.dirname(__FILE__) + "/../lib/grammoire")

grammar = Grammoire.define do
  rule(:s, :weight => 2) { 'a' + produce(:s) }
  rule(:s) { 'b' + produce(:s) }
  rule(:s) { produce(:end) }
  
  rule(:end, :weight => 10) { 'x' }
  rule(:end) { 'y' }
end

10.times { puts grammar.produce(:s) + "\n\n" }
