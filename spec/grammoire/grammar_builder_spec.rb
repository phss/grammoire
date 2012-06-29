require 'spec_helper'

describe GrammarBuilder do
  let(:builder) { GrammarBuilder.new }
  let(:grammar) { mock() }
  let(:rules) do
    rules = mock()
    Rules.stubs(:new).returns(rules)
    rules
  end

  it 'builds a grammar with a set or rules and default context class' do
    Grammar.expects(:new).with(rules, EvaluationContext).returns(grammar)
    
    builder.build.should == grammar
  end

  it 'allows overrding grammar evaluation context' do
    another_evaluation_context = mock() 

    Grammar.expects(:new).with(rules, another_evaluation_context)

    builder.context(another_evaluation_context)
    builder.build
  end

  it 'constructs and insert a rule' do
    rule_setup_block = Proc.new { :setup_block }
    new_rule = mock()

    Rule.expects(:new).with(:rule_name, &rule_setup_block).returns(new_rule)
    rules.expects(:<<).with(new_rule)

    builder.rule(:rule_name, &rule_setup_block)
  end
  
end