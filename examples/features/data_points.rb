require File.expand_path(File.dirname(__FILE__) + "/../lib/grammoire")

grammar = Grammoire.define do
  rule(:full_name) { produce { eval(:first_name) + ' ' + eval(:last_name) } }
  rule(:first_name) { produce { data(:first) } }
  rule(:last_name) { produce { data(:last) } }
end

puts grammar.evaluate(:full_name, :first => "Jonny", :last => "Data")
