require File.expand_path(File.dirname(__FILE__) + "/../lib/grammoire")

grammar = Grammoire.define do
  rule(:full_name) { produce(:first_name) + ' ' + produce(:last_name) }
  rule(:first_name) { data(:first) }
  rule(:last_name) { data(:last) }
end

puts grammar.produce(:full_name, :first => "Jonny", :last => "Data")
