require File.expand_path(File.dirname(__FILE__) + "/../lib/grammoire")

# Repeated rules
grammar = Grammoire.define do
  rule(:s) { produce(:s) + produce(:s) }
  rule(:s) { "(#{produce(:s)})" }
  rule(:s) { '()' }
end

10.times { puts grammar.produce(:s) + "\n\n" }

# Rule with multiple options (doesn't work yet...it will blow up)
grammar = Grammoire.define do
  rule :s do
    production { produce(:s) + produce(:s) }
    production { "(#{produce(:s)})" }
    production { '()' }
  end
end

10.times { puts grammar.produce(:s) + "\n\n" }
