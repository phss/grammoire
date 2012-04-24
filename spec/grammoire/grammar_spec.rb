require 'spec_helper'

describe Grammar do
  let(:grammar) { Grammar.new }
  
  it 'should raise an exception when trying to produce output for non existent rule' do
    lambda { grammar.produce(:no_such_rule) }.should raise_error(GrammarError, "Rule 'no_such_rule' doesn't exist in the grammar.")
  end

  it 'should accept rules with any type as name' do
    grammar.rule(:symbol)
    grammar.rule('string')
    grammar.rule(42)
    
    grammar.rules_names.should =~ [:symbol, 'string', 42]
  end

  it 'should produce terminal symbol of a rule' do
    grammar.rule(:terminal) { 'terminal' }

    grammar.produce(:terminal).should == 'terminal'
  end

  it 'should evaluate and substitute symbols when producing a non-terminal rule' do
    grammar.rule(:non_terminal) { 'non-' + produce(:terminal) }
    grammar.rule(:terminal) { 'terminal' }

    grammar.produce(:non_terminal).should == 'non-terminal'
  end

end