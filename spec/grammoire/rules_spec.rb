require 'spec_helper'

describe Rules do
  let(:rules) { Rules.new }

  it 'returns list of rules matching a name' do
    matching_rule_1, matching_rule_2, another_rule = rule(:matching_rule), rule(:matching_rule), rule(:another_rule)
    
    rules.for(:matching_rule).should =~ [matching_rule_1, matching_rule_2]
  end

  it 'raises an error when querying for inexistent rule' do
    lambda { rules.for(:inexistent) }.should raise_error(GrammarError, "Rule 'inexistent' doesn't exist.")
  end

  def rule(name)
    rule = Rule.new(name)
    rules << rule
    return rule
  end

end